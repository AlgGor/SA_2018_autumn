%% The first bloсk
%Text of first block
clear;
a=input('Enter the first number: ');
b=input('Enter the second number: ');
N=input('Enter the number of points: ');
x=linspace(a,b,N);
yVec=sin(x);
[maxY,indexOfMax]=max(yVec);
[minY,indexOfMin]=min(yVec);
grid on;
plot(x,yVec,'-b+',x(indexOfMin),yVec(indexOfMin),'k*',x(indexOfMax),yVec(indexOfMax),'k*');
xlabel('x');
ylabel('sin(x)');
title('Graph of sin(x)');
axis( [ min(x)-0.5, max(x)+0.5,min(yVec)-0.5, max(yVec)+0.5 ] );

%% The second block 
clear;
n=input('Enter the natural number: ');
if ~(isnumeric(n)&&(~isinf(n))&&(isscalar(n))&&isreal(n)&&(n==floor(n))&&(n>0))   %% поймать inf
    disp('The number is incorrect!');
else
% 1)
    oddVec=9:18:n;
    disp('Vector 1): ')
    if isempty(oddVec)
        disp('Empty');
    else
        disp(oddVec);
    end
% 2)
    aMat=repmat((1:n).',1,n);
    disp('Matrix 2): ');
    disp(aMat);
% 3)
    bMat=reshape([1:n*(n+1)],n+1,n).';
    disp('Matrix B 3): ');
    disp(bMat);
    cVec=reshape(bMat,[],1).';
    disp('Vector c 3): ');
    disp(cVec);
    nColB=size(bMat,2)-1;
    dMat=bMat(:,nColB:(nColB+1));
    disp('Matrix D 3): ');
    disp(dMat);

end


%% The third block
clear;
aMat=randi(100,7);
disp('The original matrix: ')
disp(aMat);
disp('The greatest diagonal''s element: ')
disp(max(diag(aMat)));
ratioMat=prod(aMat,2)./sum(aMat,2);
disp('Max ratio: ');
disp(max(ratioMat));
disp('Min ratio: ');
disp(min(ratioMat));
disp('Sorted matrix: ');
disp(sortrows(aMat));

%% The fourth block
clear;
n=input('Enter the number: ');
x=randi(10,1,n);
yVec=randi(10,1,n);
disp('Vector X:');
disp(x);
disp('Vector Y:'); 
disp(yVec);
disp('Final matrix: ');
disp( repmat(x.',1,n).*repmat(yVec,n,1) );

%% The fifth block
clear;
n=input('Enter the number: ');
if ~(isnumeric(n)&&isscalar(n)&&isfinite(n)&&isreal(n)&&(n>0)&&isprime(n))
    disp('Not prime! ');
else
    aMat=randi(50,n);
    bVec=(randi(1000,1,n)).';
    disp(aMat);
    disp(bVec);
    if abs(det(aMat))<eps
        disp('Degenerate matrix! ');
    else
        disp('The first way solution: ');
        x= aMat\ bVec;
        disp(x);
        disp('Discrepancy of the first solution: ');
        disp(norm(bVec-aMat*x,inf));
        disp('The second way solution: ');
        x= inv(aMat)*bVec;
        disp(x);
        disp('Discrepancy of the second solution: ');
        disp(norm(bVec-aMat*x,inf));
    end
end

%% The sixth block
clear;
n=input('Enter number of columns in a : ');
m=input('Enter number of columns in b: ');
aVec=randi(50, 1,n);
bVec=randi(40, 1,m);
disp(aVec);
disp(bVec);
%abs(aMax-bMin)
%abs(aMax-bMax)
%abs(aMin-bMin)
%abs(aMin-bMax)

%aMax=max(aVec);
%aMin=min(aVec);
%bMax=max(bVec);
%bMin=min(bVec);

disp( max( max( max( max( max( max( max(max(aVec)-min(bVec),min(bVec)-max(aVec)), max(aVec)-max(bVec)), max(bVec)-max(aVec)), min(aVec)-min(bVec)), min(bVec)-min(aVec)), min(aVec)-max(bVec)), max(bVec)-min(aVec)) ); 



%% The seventh block
clear;
format short;
n=input('Enter dimention : ');
k=input('Enter number of points: ');
rMat=randi(10,n,k);
disp(rMat);
rCopyMat=repmat(rMat,[1 1 k]);
r3dMat=permute(rCopyMat,[1 3 2]);
r3dMat=r3dMat-rCopyMat;
rSqarMat=permute(sum(r3dMat.^2,1),[1 3 2]);
rSqarMat=permute(rSqarMat,[3 2 1]);
rSqarMat=(rSqarMat(:,:,1));
disp(rSqarMat);

%% The eighth block
clear;
n=input('Enter the dimention: ');
nVec=0:(2^n-1);
disp('    Dec        Binary ')
disp(' -------- ----------------')
disp([nVec.', fliplr(de2bi(nVec,n))]);

%% Theninth block
clear;
format long;
n=20;
myTimeVec=zeros(1,n);
defTimeVec=zeros(1,n);

for v=1:n
    aMat=randi(100,v);
    bMat=randi(100,v);
    count=20;
    timeVec=1:count;
    for ind=1:count
        tic;
        aMat*bMat;
        timeVec(ind)=toc;
    end
    defTimeVec(v)=median(timeVec);
    for ind=1:count
        tic;
        my_multipy(aMat,bMat);
        timeVec(ind)=toc;
    end
    myTimeVec(v)=median(timeVec);
    clear aMat;
    clear bMat;
end

plot([1:n],defTimeVec,'-r*',[1:n],myTimeVec,'-gx');
xlabel('The size of the matrix');
ylabel('Time');
legend('Def','My');
title('Time of multipying');

%% The tenth block
clear;
xMat=[nan,1,2;nan,0,6;1,5,nan];
disp('The original matrix: ');
disp(xMat);
isNanMat=~isnan(xMat);
disp(nansum(xMat)./sum(isNanMat));


%% The eleventh block
clear;
format short;
n=input('Enter the number: ');
aVec=repmat(-5+10.*rand,1,n);
sigmaVec=repmat(sqrt(10.*rand),1,n);
nVec=aVec+sigmaVec.*randn(1,n);
is3sigma=( abs(nVec-aVec)./(3.*sigmaVec))<1;
disp(sum(is3sigma.')/n);

%% The twelveth block
clear;
h=.01;
xVec=[h:h:10];
yVec=sin(xVec)./xVec;   
figure(2)
plot(xVec,cumtrapz(xVec,yVec),'-r');
hold on;
plot(xVec,cumRectangles(xVec,yVec),'-g');
plot(xVec(1:2:size(xVec,2)),cumSimpsons(xVec,yVec),'-b');
xlabel('x');
ylabel('sin(x)/x');
legend('Trapz','Rect','Simpsons');
title('Graph of primitive sin(x)/x');
hold off;

clear xVec;
clear yVec;

n=input('Enter the number: ');
hVec=2.^(-1.*(1:n));
TrapzVec=1:n;
RectVec=1:n;
SimpVec=1:n;
timeTrapzVec=1:n;
timeRectVec=1:n;
timeSimpVec=1:n;
m=10;
timeEachVec=1:m;
integrEachVec=1:m;

for indH=1:n
    xVec=hVec(indH):hVec(indH):5;
    yVec=sin(xVec)./xVec; 
    for indTime= 1:m
        tic;
        integrEachVec(indTime)=trapz(xVec,yVec);
        timeEachVec(indTime)=toc;
    end
    timeTrapzVec(indH)=median(timeEachVec);
    TrapzVec(indH)=median(integrEachVec);
    
    for indTime= 1:m
        tic;
        integrEachVec(indTime)=rectangles(xVec,yVec);
        timeEachVec(indTime)=toc;
    end
    timeRectVec(indH)=median(timeEachVec);
    RectVec(indH)=median(integrEachVec);
    
    for indTime= 1:m
        tic;
        integrEachVec(indTime)=simpsons(xVec,yVec);
        timeEachVec(indTime)=toc;
    end
    
    timeSimpVec(indH)=median(timeEachVec);
    SimpVec(indH)=median(integrEachVec);
    clear xVec;
    clear yVec;
end


trapzErrorVec=diff(TrapzVec);
rectErrorVec=diff(RectVec);
simpsErrorVec=diff(SimpVec);
figure(3)
plot(log2(hVec(1:n-1)),trapzErrorVec,'-r');
hold on;
plot(log2(hVec(1:n-1)),rectErrorVec,'-g');
plot(log2(hVec(1:n-1)),simpsErrorVec,'-b');
xlabel('Step');
ylabel('Error');
legend('Trapz','Rect','Simpsons');
title('Graph of errors');
hold off;

figure(4)
plot(log2(hVec),timeTrapzVec,'-r');
hold on;
plot(log2(hVec),timeRectVec,'-g');
plot(log2(hVec),timeSimpVec,'-b');
xlabel('Step');
ylabel('Time');
legend('Trapz','Rect','Simpsons');
title('Time of counting');
hold off;




%% The thirteenth block
clear;
format longEng;
x=randi(7);
start=5;
final=60;
step=0.5;
hVec=exp(-[start:step:final]);
xVec=repmat(x,1,(final-start)/step+1);
difExecVec=cos(xVec);
difRtVec=(sin(xVec+hVec)-sin(xVec))./hVec;
difCentrVec=(sin(xVec+hVec)-sin(xVec-hVec))./(hVec.*2);
loglog(hVec,abs(difRtVec-difExecVec),'-r',hVec,abs(difCentrVec-difExecVec),'-b');
xlabel('log(h)');
ylabel('log(error)');
title('Error in numerical differentiation');
legend('Central','Right');
