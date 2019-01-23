%% The fourth task

copyfile(fullfile(matlabroot,'extern','examples','mex','yprime.c'),'.','f');

%%
clear;  
mex('quadsolve.c','-R2018a');



%%  The third block
clear;

m=1;
n=1;

aMat=randi(10,m,n)+1i*randi(10,m,n);
bMat=randi(10,m,n)+1i*randi(10,m,n);
cMat=randi(10,m,n)+1i*randi(10,m,n);

[x1,x2,dMat]=quadsolve(aMat,bMat,cMat);


    
%% 
aMat=[1,2;3,2];
disp('new');
bMat=inv_c(aMat);
disp(bMat);

disp(aMat);
disp(aMat*bMat);
%%
aMat=[1,2;3,2];
disp(aMat*bMat);
%%
aMat=[1 2;3 2];
invMat=inv_matlab(aMat);
disp(invMat);
disp(aMat*bMat);
%%
disp(ones(size(aMat,1),1));
disp(linsolve(aMat,eye(size(aMat,1))));


%% The fifth part
clear;
%%
clear;
n1=0;
n2=0;
n3=0;
n4=0;
xVec=4:8;
n1Vec=4:8;
n2Vec=n1Vec;
n3Vec=n2Vec;
n4Vec=n3Vec;
aMat=randi(10,4,4);
for n=xVec
    n1=0;
    n2=0;
    n3=0;
    n4=0;
    for k=1:5
        aMat=randi(10,n,n);
        n1=n1+sum(sum((inv(aMat).*inv(aMat))));
        n2=n2+sum(sum((linsolve(aMat,eye(size(aMat,1)))).*linsolve(aMat,eye(size(aMat,1)))));
        %n3=n3+sum(sum((inv_matlab(aMat).*inv_matlab(aMat))));
        n4=n4+sum(sum((inv_c(aMat).*inv_c(aMat))));
    end
    n1Vec(n-3)=n1/5;
    n2Vec(n-3)=n2/5;
    n3Vec(n-3)=n3/5;
    n4Vec(n-3)=n4/5;
end    
nStd=(n1Vec+n2Vec+n3Vec+n4Vec)/4;
disp(n1Vec-nStd);
disp(n2Vec-nStd);
disp(n3Vec-nStd);
disp(n4Vec-nStd);

plot(xVec,n1Vec-nStd,xVec,n2Vec-nStd,xVec,n3Vec-nStd,xVec,n4Vec-nStd);
xlabel('Matrix dimention')
ylabel('Difference in value');
legend('inv','linsolve','inv_matlab','inv_c');

%%
clear;
n1=0;
n2=0;
n3=0;
n4=0;
xVec=20;
n1Vec=20;
n2Vec=n1Vec;
n3Vec=n2Vec;
n4Vec=n3Vec;
aMat=randi(10,20,20);
for n=xVec
    n1=0;
    n2=0;
    n3=0;
    n4=0;n3Vec
    for k=1:5
        aMat=randi(10,n,n);
        tic;
        inv(aMat);
        n1=n1+toc();
        tic;
        linsolve(aMat,eye(size(aMat,1)));
        n2=n2+toc();
        tic;
        inv_matlab(aMat);
        n3=n3+toc();
        tic;
        bMat=inv_c(aMat);
        n4=n4+toc();
    end
    n1Vec(n-3)=n1/5;
    n2Vec(n-3)=n2/5;
    n3Vec(n-3)=n3/5;
    n4Vec(n-3)=n4/5;
end    
disp(n1Vec);
disp(n2Vec);
disp(n3Vec);
disp(n4Vec);

plot(xVec,n1Vec,xVec,n2Vec,xVec,n3Vec,xVec,n4Vec);
xlabel('Matrix dimention')
ylabel('Difference in time');
legend('inv','linsolve','inv_matlab','inv_c');


