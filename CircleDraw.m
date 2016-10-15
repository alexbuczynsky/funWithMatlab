clc;clear;
for jj = 1:10
tic
image = uint8(zeros(500,500,3));
step = 0;
for ii = 10:20:250
    RGB = [256 256 256];
    
    image = image + DrawCircle(ii,250,250,RGB,image);
    step = step + 1;
    
    if mod(ii,2)==0
%         if mod(ii,1000)==0
%             imshow(image)
% %             fprintf('\n')
%         end
%         fprintf('%3d, \n',step)
        
    end
end
imshow(image)
disp(' ')
toc
end