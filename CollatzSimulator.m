%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%                     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%  COLLATZ  SIMULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%                     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%        AUTHOR       %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%                     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% ALEXANDER BUCZYNSKY %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
%% Initial Setup / Information
Ni      = input('Enter starting number:');
Nf      = input('Enter final number:');
i       = input('Increments of:');
graphs  = input('Graphs during simulation? (y/n): ','s');
peak    = [];
steps   = [];
jj      = 1;
%% Set Up Waiting Status Bar
Waiting = waitbar(0,'1',...
    'Name',...
    'Collatz values being calculated...',...
    'CreateCancelBtn',...
    'setappdata(gcbf,''canceling'',1)');
setappdata(Waiting,'canceling',0)

tic
Ti = double(tic);

%% Simulate for range specified
for ii = Ni:i:Nf
    %% Run Collatz Function Instance Simulator
    [ns , seq]  = collatz(ii);
    peak(jj)    = max(seq);
    steps(jj)   = ns;
    
    %% Time Estimation
    Tc          = double((tic)-Ti)*10^-9; %Current seconds elapsed
    Nc          = Ni+(jj-1)*i;
    ratioN      = (Nc-Ni)/(Nf-Ni);
    estTf       = Tc/ratioN-Tc;
    
    
    %% Plot Graph
    if strcmp(graphs,'y')
        figure(2)
        plot([Ni:i:Ni+(jj-1)*i],peak)
    end
    jj          = jj + 1;
    
    %% Handle Wait Bar
    if getappdata(Waiting,'canceling')
        break
    end
    waitbar(ratioN,Waiting,sprintf(...
        'N: %8d/%d , Max: %8.2E StepAvg: %3.2f (%2.2f%%, %.2f sec)',...
        Nc,Nf, max(peak),mean(steps),round(ratioN*100,3),estTf))
end
close(Waiting)
set(groot,'ShowHiddenHandles','on')
delete(get(groot,'Children'))
fprintf('Max peak: \t%8.2E \nStarting number(s):\n',max(peak))

fprintf('\t%d \n',find(peak == max(peak)))
fprintf('\n')
fprintf('Average Steps: \t %3.2f\n',mean(steps))

figure(2)
plot([Ni:i:Nc],peak)
toc