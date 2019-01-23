%% The first task
clear;
fig1=figure(1);

func1=@(tVec) cos(tVec).*exp(-2*abs(tVec));
ftfunc1=@(hVec) 4*(hVec.^2+5)./(hVec.^4+6*hVec.^2+25);

step=0.011;
inpLimVec=[-30,10];
outLimVec=[-9,9];

plotFT(fig1,func1,ftfunc1,step,inpLimVec,outLimVec);
print('FirstFFtSpec2','-depsc');

%% 
clear;
fig2=figure(2);

func2=@secondFFT;
ftfunc2=@(hVec) 1j*(pi*sign(hVec)-2*atan(hVec));

step=0.001;
inpLimVec=[-90,10];
outLimVec=[-2*pi,2*pi];

plotFT(fig2,func2,ftfunc2,step,inpLimVec,outLimVec);

print('SecondFFt2','-depsc');


%%
clear;
fig3=figure(3);
func3=@(tVec) atan(tVec.^2)./(1+tVec.^4);

step=0.001;
inpLimVec=[-30,30];
outLimVec=[-10,10];

plotFT(fig3,func3,[],step,inpLimVec,outLimVec);

print('ThirdFFt1','-depsc');

%% 
fig4=figure(4);

func4=@(tVec) (tVec.^3).*exp(-tVec.^4);

step=0.001;
inpLimVec=[-5,1];
outLimVec=[-10,10];

plotFT(fig4,func4,[],step,inpLimVec,outLimVec);

print('FourthFFtW1','-depsc');

