%% task4n4
clear;
%A  = [1, 9, 7+1i, 2; 1,0 ,1, 8; 9, 1, 0, 1; 1, 2, 3,4*1i ];
%A  = [0.2, 0.9, 0.2; 0 ,0.1, 0.8; 0.9, -100, 0];
%A  = complex([2, 9, 2; 0 ,1, 8; 9, -100, 0]);
%A  = complex([1, 9, 7, 2; 1,1 ,7, 8; 1, 1, 1, 6*1i; 1, 1, 1,1 ]);
A = [1, 1, 1; 1, 1,1 ; 1, 1,1 ];
%A = [8, 9; 7, 6];
%A = [8*1i, 9*1i; 7*1i, 6*1i];
%%

%A = A*1i;
C = inv_matlab(A.');
C = C.';
B = inv_c(A);
%D = linsolve(A, eye(size(A, 1)));
disp(abs(inv(A) - B));
disp(abs(inv(A) - C));

disp(inv(A));
disp(C);
disp(B);

%% task4n5, task4n6
n  = 50;
m = 5;
tVecM = zeros(1,n);
tVecC = zeros(1,n);
tVecL = zeros(1,n);
tVecInv = zeros(1,n);

tVecMm = zeros(1,m);
tVecCm = zeros(1,m);
tVecLm = zeros(1,m);
tVecInvm = zeros(1,m);

deltaVecM = zeros(1,n);
deltaVecC = zeros(1,n);
deltaVecL = zeros(1,n);

deltaVecMm = zeros(1,m);
deltaVecCm = zeros(1,m);
deltaVecLm = zeros(1,m);

for i=1:n
    for j= 1:m
        A = 100*rand(i) - 100*rand(i) +rand(i) + 100*rand(i)*1i + eye(i);
    
        t1 = tic;
        Ainv = inv(A);
        tVecInvm(j) = toc(t1);
    
        t2 = tic;
        AinvM = inv_matlab(A);
        tVecMm(j) = toc(t2);
    
        t3 = tic;
        AinvC = inv_c(A);
        tVecCm(j) = toc(t3);
    
        t4 = tic;
        AinvL = linsolve(A, eye(size(A, 1)));
        tVecLm(j) = toc(t4);
    
        deltaVecMm(j) = sum(sum(abs(Ainv - AinvM)));
        deltaVecCm(j) = sum(sum(abs(Ainv - AinvC)));
        deltaVecLm(j) = sum(sum(abs(Ainv - AinvL)));
    end
    
    tVecInv(i)= mean(tVecInvm);
    tVecM(i)= mean(tVecMm);
    tVecC(i)= mean(tVecCm);
    tVecL(i)= mean(tVecLm);
    deltaVecM(i) = mean(deltaVecMm);
    deltaVecC(i) = mean(deltaVecCm);
    deltaVecL(i) = mean(deltaVecLm);
    
    
end

figure();

plot( 1:n, deltaVecM, 'b', 1:n,deltaVecM, 'm--',  1:n,deltaVecL, 'y');
title('Error in coparison with inv');
legend('inv matlab', 'inv c', 'linsolve');
xlabel('Matrix dimesion');
ylabel('Error');

figure();
plot(1:n, tVecInv, 'g', 1:n, tVecM, 'b', 1:n, tVecC, 'm', 1:n, tVecL, 'y');
title('Time, required for inversion');
legend('inv', 'inv matlab', 'inv c', 'linsolve');
xlabel('Matrix dimesion');
ylabel('Seconds');


