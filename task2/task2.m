%% The first block
clear;
n=10;
xVec=linspace(1,10,n+1);
xxVec=linspace(1,10,4*n+1);
f=@sin;
figure(2);
compareinterp(xVec,xxVec,f);

%% The second block
clear;
n=30;
xVec=linspace(1,30,n+1);
xxVec=linspace(1,30,4*n+1);

figure(1);
f1=@tan;
compareinterp(xVec,xxVec,f1);

figure(2);
f2=@sin;
compareinterp(xVec,xxVec,f2);


figure(3);
f3=@(x) sqrt(abs(sin(x)));
compareinterp(xVec,xxVec,f3);

figure(4);
f4=@(x) 1./x;
compareinterp(xVec,xxVec,f4);

%% The third block



%% The fourth block
clear;

fn= @(xVec,n) ((n*xVec).*sin(xVec/n));
f=@(x) x.^2;
n=50;
a=1;
b=10;
convType='point';
convergenefunc(fn,f,a,b,n,convType);
    
clear;
fn= @(xVec,n) (n*sin((n*xVec).^(-1)));
f=@(x) x.^(-1);
n=200;
a=0.5;
b=10;
convType='uniform';
convergenefunc(fn,f,a,b,n,convType);

clear;
fn=@(xVec,k) xVec.^(1-1/k);
f=@(xVec) zeros(1,size(xVec,2));
a=0.1;
b=1;
n=50;
convType='rms';
convergenefunc(fn,f,a,b,n,convType);

%% The fifth block
f=@(xVec) sin(xVec.^2);
a=-5;
b=5;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
n=30;        
meth='legen';
fourierapprox(f,a,b,n,meth)


%% The sixth block

% in task6_2 file

%% The seventh block

% in getequal.m
clear;
A=2;
B=2;
a=1;
b=2;
delta=pi/2;
t0=0;
t1=2*pi;
N=100;


f=@(t) A*sin(a.*t+delta);
g=@(t) B*sin(b.*t);

tVec=linspace(t0,t1,N*10);
xVec=f(tVec);
yVec=g(tVec);

plot(xVec,yVec,'b');

resVec=getequal(f,g,t0,t1,N);

xVec=f(resVec);
yVec=g(resVec);

hold on;
plot(xVec,yVec,'rd');
hold off;

%% The eights block
    
drawset(rho,30,'on');


%% The ninth block
clear;
a=4;
b=2;
x0=-4;
y0=-6;
f=@(xVec) ((xVec(1)-x0)/a)^2+((xVec(2)-y0)/b)^2-0;

opts = optimoptions('fmincon','Display','None');
myEps=0.00001;
rho=supportLebesgue(f,opts,myEps);
tVec=[0,0];
[val,point]=rho([-1,-1]);
disp(['val: ',num2str(val)]);
disp('point: ');
disp(point);

%% The tenth block

drawpolar(rho,30);


%% The eleventh and twelfth block

%in TheThirdPart.m
clear;

%% The thirdteenth block
clear;
nPoints=randi(20);
maxCoord=randi(30);
pointsMat=randi([-maxCoord,maxCoord],nPoints,2);
disp('PointsMatInProg');
disp(pointsMat);
p=5;
l=4.5;
viewpoints(pointsMat,p,l);

%% The fourteenth block
clear;

alpha=2;
params=struct('nPoints',1000,'FaceColour','blue','EdgeColour','green','FaceAlpha',0.5,'manyBalls','off');
params.EdgeColour='none';
params.FaceColour='red';
params.nPoints=1000000;
params.manyBalls='off';

drawball(alpha,params);

%% The fiveteenth block
clear;
alpha=[2,3,Inf];
colors=['blue','red','cyan'];
params=['green','black','none'];
drawmanyballs(alpha, colors, params);

%% Test block
clear;

f1=@(xVec) xVec;

f2=@(xVec) sin(xVec);

f3=@(xVec) f1(xVec).*f2(xVec);

disp(f3([1:5]));

%%
drawPolar2(rho,25);


