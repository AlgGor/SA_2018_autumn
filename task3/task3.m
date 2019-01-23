%% The third block
clear;

nVec=0:10;

curEl=1;
sumN=1;
errVec=[exp(1)-1,1:nVec(end)];

for k=1:nVec(end)
    curEl=curEl/nVec(k+1);
    sumN=sumN+curEl;
    errVec(k+1)=exp(1)-sumN;
    
end


plot(nVec,errVec,'r',nVec,phiThirdBlock(nVec),'b');
legend('error func','phi');


%% The fourth block
clear;

xVec=0.1:0.1:20;

plot(xVec,sqrt(xVec),xVec,tan(xVec));
[x,~]=ginput(1);
disp(x);
ans=fzero(@thirdBlockFunc,x(1));
hold on;
plot(ans,sqrt(ans),'d');
disp(ans);

%% The fifth block
clear;

N=10000;
xVec=linspace(-1,1,N);

fun=@fourthBlockFunc;

yVec=ones(1,N);

for k=1:N
    yVec(k)=fzero(fun,xVec(k)); 
end   

plot(xVec,yVec);
xlabel('init appr');
ylabel('root');


%% The sixth block
clear;

alpha=0.4;
tstart = 0;
tfinal = 21;
y0 = [1; 2];
options = odeset('Events',@igorsEvents,'OutputFcn',@odeplot,'OutputSel',1);

fig = figure(3);
ax= axes;
ax.XLim = [0 16];
%ax.YLim= [-1 5];
box on
hold on;

fun=@(tVec,yVec) sixthDe(tVec,yVec,alpha);
tout = tstart;
yout = y0.';
teout = [];
yeout = [];
ieout = [];


while true
   % Solve until the first terminal event.
   if tstart==tfinal
       break
   end
   [t,y,te,ye,ie] = ode45(fun,[tstart tfinal],y0,options);
   
   nt = length(t);
   tout = [tout; t(2:nt)];
   yout = [yout; y(2:nt,:)];
   teout = [teout; te];          
   yeout = [yeout; ye];
   ieout = [ieout; ie];
   
   y0(1) = 0;
   y0(2) = -y(nt,2);
   
   tstart = t(nt);
end

plot(teout,yeout(:,1),'ro');
xlabel('time');
ylabel('height');
title('Ball trajectory and the events');    
hold off
odeplot([],[],'done');



%% The seventh block
clear;

m1=10;
m2=100;

figure(3);
cla(gcf);

tstart = 0;
tfinal = 100;
x1InitVec=[1;1;1];
x2InitVec=[-1;-1;-1];
v1InitVec=[1;-1;0];
v2InitVec=[0;0;0];
condInitVec = [x1InitVec;x2InitVec;v1InitVec;v2InitVec];

fun=@(tVec,xVec) gravity(tVec,xVec,m1,m2);


[t,trajMat] = ode45(fun,[tstart tfinal],condInitVec);
   
x1Mat=trajMat(:,1:3).';
x2Mat=trajMat(:,4:6).';


nFrames=100;

mov(1:nFrames) = struct('cdata', [],'colormap', []);
fr= floor(size(x1Mat,2)/nFrames);

for k=1:nFrames
    
    plot3(x1Mat(1,1:k*fr),x1Mat(2,1:k*fr),x1Mat(3,1:k*fr));
    hold on;
    plot3(x2Mat(1,1:k*fr),x2Mat(2,1:k*fr),x2Mat(3,1:k*fr));
    hold off;
    mov(k)=getframe(); 
    
end

f=fit([[x1Mat(1,:),x2Mat(1,:)].',[x1Mat(2,:),x2Mat(2,:)].'],[x1Mat(3,:),x2Mat(3,:)].','poly11');

hold on;
plot(f);
hold off;

%movie(mov,1,3);

%% The eight block

clear;

tstart = -5;
tfinal = 5;
y0Mat=[10,10];

for k=-10:2:10
    y0Mat=cat(1,y0Mat,[10,k],[k,10],[-10,k],[k,-10]);
end    

y1Mat=[.1,.1];

for k=-.1:.02:.1
    y1Mat=cat(1,y1Mat,[.1,k],[k,.1],[-.1,k],[k,-.1]);
end    

opt= odeset('OutputFcn',@odephas2,'OutputSel',[1 2]);

hF1=figure(2);
hF2=figure(3);
hF3=figure(4);
hF4=figure(5);
hF5=figure(6);


for k=1:size(y0Mat,1)
    figure(hF1);
    hold on;
    [t,y] = ode45(@firstEigthDe,[0 1],y1Mat(k,:),opt);
    figure(hF2);
    hold on;
    [t,y] = ode45(@secondEigthDe,[-1 5],y1Mat(k,:),opt);
    figure(hF3);
    hold on;
    [t,y] = ode45(@thirdEigthDe,[-1 1],y0Mat(k,:),opt);  
    figure(hF4);
    hold on;
    [t,y] = ode45(@fourthEigthDe,[tstart tfinal],y0Mat(k,:),opt);
    figure(hF5);
    hold on;
    [t,y] = ode45(@fifthEigthDe,[tstart tfinal],y0Mat(k,:),opt);
end

hold off;
figure(hF1);
odephas2([],[],'done');
figure(hF2);
odephas2([],[],'done');
figure(hF3);
odephas2([],[],'done');
figure(hF4);
odephas2([],[],'done');
figure(hF5);
odephas2([],[],'done');



%% The ninth block

clear;

tstart = -20;
tfinal = 20;
y0Mat=[10,10];

fL1=@(xVec,yVec) (xVec+yVec).^2+(yVec.^4)/2;
fL2=@(xVec,yVec) xVec.*yVec;

xVec=[-10:10];
yVec=[-10:10];
[xMat,yMat]=meshgrid(xVec,yVec);
z1Mat=fL1(xMat,yMat);
z2Mat=fL2(xMat,yMat);

for k=-10:2:10
    y0Mat=cat(1,y0Mat,[10,k],[k,10],[-10,k],[k,-10]);
end    

opt= odeset('OutputFcn',@odephas2,'OutputSel',[1 2]);

hF1=figure(2);
hF2=figure(3);

for k=1:size(y0Mat,1)
    figure(hF1);
    hold on;
    [t,y] = ode45(@firstNinethDe,[tstart tfinal],y0Mat(k,:),opt);
    contour(xMat,yMat,z1Mat,[k k]);
    figure(hF2);
    hold on;
    [t,y] = ode45(@secondNinethDe,[tstart tfinal],y0Mat(k,:),opt);
    contour(xMat,yMat,z2Mat,[k k]);
end

hold off;
figure(hF1);
odephas2([],[],'done');
figure(hF2);
odephas2([],[],'done');


%% The tenth block
clear;

solinit = bvpinit(linspace(0,1,5),[1 0]);

sol = bvp4c(@tenthDe,@tenthBc,solinit);

xVec = linspace(0,1,10);

yQuanSol = deval(sol,xVec);

plot(xVec,yQuanSol(1,:),'-b');
xlabel('x');
ylabel('y');
axis equal tight;

%mySol=@(xVec) exp.^(xVec)-2;

mySol=exp(xVec)-2;
%hold on; plot(xVec,mySol); hold off;
erL2=sqrt(trapz(xVec,(yQuanSol(1,:)-mySol).^2));
disp(' ');
disp(['erL2: ',num2str(erL2)]);
erC=max(abs(yQuanSol(1,:)-mySol));
disp(['erC: ',num2str(erC)]);


 
 

