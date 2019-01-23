%% task4n3
clear;
%A = zeros(3,2);
A = [1e-17, 0; 1, 1; 6, 9];
B = [1i, 0; -3, -2*1i; 7, 9];
C = [1, 4; 2, 1; 2*1i, 6+1i];
[x1, x2] = quadsolve(A, B, C);
disp('First root');
disp(reshape(x1.',1, [] ));
disp('Second root');
disp(reshape(x2.',1, [] ));


