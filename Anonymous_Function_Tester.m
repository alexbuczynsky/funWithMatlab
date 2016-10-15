%EGM3344 Homework 2
%Author: Alexander Buczynsky
%UFL Login Username: alexbuczynsky


%% QUESTION 1
clc;clear;
format LONG
P = 22000;      %initial interest
r = 0.5/100;    %percent interest rate
A = @(P,r,t) P*(1+r)^t;
t = 0;
V = P;
while P >= 0
    P = A(P,r,t);
    P = P - 300;
    disp(P)
    pause(0.5)
    
    t = t + 1;
end

fprintf('Months to pay off: %d \nAmount of last payment: %.2f',...
    t,P+300)
pause


%% QUESTION 2


