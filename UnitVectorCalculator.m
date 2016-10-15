%COP2271 Lab Week 1 - Activity 1
%Author: Alexander Buczynsky
%UFL Login Username: alexbuczynsky

clc; clear;

disp('Greetings... Welcome to the Unit Vector Calculator.')
disp('Follow the prompts to calculate an orthonormal vector basis of your choosing.')
disp('Press any key to continue...')
pause

clc; clear;

e1   = input('What is the vector magnitude in the e1 direction? ');
e2   = input('What is the vector magnitude in the e2 direction? ');
e3   = input('What is the vector magnitude in the e3 direction? ');

u    = abs(sqrt(e1^2+e2^2+e3^2));
u_e1 = e1/u;
u_e2 = e2/u;
u_e3 = e3/u;

disp(' ')
fprintf('The unit vector magnitude is %.2f',u)
disp(' ')
fprintf('The unit vector is {(%.00f/%.00f)e1 + (%.00f/%.00f)e2 +(%.00f/%.00f)e3}',e1,u,  e2,u,  e3,u)