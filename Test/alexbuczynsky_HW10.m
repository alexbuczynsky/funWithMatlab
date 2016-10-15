clc;clear;
file = fopen('maze.txt','r');
maze = {};
R=1;
%% CREATE INDIVIDUAL MAZE COLORED BLOCKS
while true
    line = fgetl(file);
    if line == -1
        break
    end
    
    maze{R,1} = regexprep(line,' ','');
    
    R = R + 1;
end
maze = cell2mat(maze);

%IMAGE PARAMETERS
blockSize = uint8(zeros(50,50,3));

%White block
blockWhite = blockSize;
blockWhite(:,:,1:3) = 255;
blockWhite(1,:,1:3) = 0;
blockWhite(end,:,1:3) = 0;
blockWhite(:,1,1:3) = 0;
blockWhite(:,end,1:3) = 0;

%Black block
blockBlack = blockSize;

%Start location (green)
blockStart = blockWhite;
blockStart(:,:,[1 3]) = 0;

%Finish location
blockFinish = blockWhite;
blockFinish(:,:,[1 2]) = 0;

%Test block
blockTest = blockWhite;
blockTest(:,:,[2 3]) = 0;

%% GENERATE MAZE IMAGE
finalMaze = [];

for R = 1:size(maze)
    %find line length
    [~,lineLgth]=size(maze);
    %reset parameters
    finalMazeRow = [];
    %read line and set positions
    for C = 1:lineLgth
        %number/block codex
        %0: blockWhite      (path robot can go)
        %1: blockBlack      (path robot cannot go)
        %8: blockStart      (path start)
        %9: blockFinish     (path finish)
        
        index = maze(R,C);
        
        if index == '0'
            block = blockWhite;
        elseif index == '1'
            block = blockBlack;
        elseif index == '8'
            block = blockStart;
        elseif index == '9'
            block = blockFinish;
        else
            disp('ERROR!!!')
        end
        finalMazeRow = cat(2,finalMazeRow,block);
    end
    finalMaze = cat(1,finalMaze,finalMazeRow);
    imwrite(finalMaze,'Maze.png','png')
end
f1 = figure(1)
f1.Name = 'Text to Matlab';
imshow(finalMaze)

%% FIND THE PATH!!!
if maze(maze=='9') == '9'
else
    disp('No possible path...')
    return
end

%Parce matrix and check neighbor values for 0 or 9
posStart = [];
[posStart(2), posStart(1)] = find(maze == '8');
posCurrent  =   posStart;
direction   =   [ 0 ,  -1]; %[ x , y ]
posNext     =   posCurrent + direction;
step        =   1;
fprintf('Start Position: [ %d , %d ] \n\n\n', posStart(1), posStart(2))
memoryMatrix = maze;
f2 =figure(2);
f2.Name = 'Maze Solution finder Animation';
f2.Position = get(0,'screensize');
a = gca;
axis square equal
while true
    %% MAZE ANIMATION / INITIAL PARAMETERS
    finalTempMaze = finalMaze;  x = posCurrent(1);  y = posCurrent(2);
    finalTempMaze((y-1)*50+1:y*50, (x-1)*50+1:x*50,[1:3]) =  blockTest;
    image(finalTempMaze)
    
    %% CHECK IF END IS IN ANY DIRECTION
    if x ~= 1 && x ~= size(maze,1) && y~=1 && y ~= size(maze,2) %do not check values at extremes
        if maze(y,x) == '9' || maze(y-1,x) == '9' || maze(y,x+1) == '9' || maze(y,x-1) == '9'
            clc; fprintf('Maze has a solution! HUZZAH \nAuthor: Alexander Buczynsky\n')
            break
        end
    end
    %Check if all paths have been taken
    if isempty(memoryMatrix(memoryMatrix=='0')) || step > 200
        clc
        disp('No possible path...')
        break
    else
        
    end
    
    %MONITORING VALUES IN BACKGROUND
    fprintf('Current index position: [ %2d , %2d ]; value: (%s) \n', y , x, maze(y,x))
    
    %following if-statement prioritizes the change in direction when the
    %current block has already been scanned before e.g. index == '3'
    tempDirection = direction([2 1]);
    tangentPos = posCurrent + tempDirection;
    tangentNeg = posCurrent - tempDirection;
    
    if maze(posNext(2),posNext(1)) == '0' && memoryMatrix(posNext(2),posNext(1)) ~= '3'
        %No change in direction. Continue along path...
    else
        if memoryMatrix(y,x) == '3'
            %when positive is '3' and negative is '0' go to '0'
            valuePos = maze(tangentPos(2),tangentPos(1));
            valueNeg = maze(tangentNeg(2),tangentNeg(1));
            if valuePos == '0'
                direction = tempDirection;
            elseif valueNeg == '0'
                direction = -tempDirection;
            end
        end
        %the following if statement handles cases when the block is white and
        %hasn't been scanned before
        if memoryMatrix(y,x) ~= '3'
            if maze(posNext(2),posNext(1)) == '1'
                %if along the current path the next position is black:
                if maze(tangentPos(2),tangentPos(1)) == '0'
                    %if maze position perpendicular-positive (right) is '0':
                    direction = tempDirection;
                elseif maze(tangentNeg(2),tangentNeg(1)) == '0'
                    %if maze position perpendicular-negative (left) is '0':
                    direction = -tempDirection;
                else
                    %Change directions:
                    direction = -direction;
                end
            end
        end
    end
    
    memoryMatrix(y,x) = '3';
    posCurrent  =   posCurrent + direction;
    posNext     =   posCurrent + direction;
    step = step + 1;
    drawnow
end