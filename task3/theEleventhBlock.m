%% The eleventh block

%   grMat=@(xVec) [f1(xVec), f2(xVec), f3(xVec), f4(xVec) ];

%   HMat=@(xVec) [  f11(xVec), f12(xVec), f13(xVec), f14(xVec);
%                   f21(xVec), f22(xVec), f23(xVec), f24(xVec);
%                   f31(xVec), f32(xVec), f33(xVec), f34(xVec);
%                   f41(xVec), f42(xVec), f43(xVec), f44(xVec)];
        
%-------------
f1=@(xVec) (2*xVec(1))*(sin(xVec(1))).^2+sin(2*xVec(1)).*((xVec(1)).^2);


f11=@(xVec) 4*xVec(1)*sin(2*xVec(1))+2*(sin(xVec(1))).^2+2*(xVec(1).^2).*cos(2*xVec(1));



HMat=@(xVec) [ f11(xVec)];
 
grVec=@(xVec) [f1(xVec)];

%-------------
% f2=@(xVec) (2*xVec(2))*(sin(xVec(2))^2)+sin(2*xVec(2))*(xVec(2)^2);
% 
% 
% f12=@(xVec) 0;
% 
% f21=@(xVec) 0;
% f22=@(xVec) 4*xVec(2)*sin(2*xVec(2))+2*(sin(xVec(2))^2)+2*(xVec(2)^2)*cos(2*xVec(2));
% 
% HMat=@(xVec) [   f11(xVec), f12(xVec);
%                  f21(xVec), f22(xVec) ];
% 
% grVec=@(xVec) [f1(xVec); f2(xVec)];

%-------------
% f3=@(xVec,) 0;
% 
% 
% f13=@(xVec) 0;
% f23=@(xVec) 0;
% 
% f31=@(xVec) 0;
% f32=@(xVec) 0;
% f33=@(xVec) 0;

% HMat=@(xVec) [   f11(xVec), f12(xVec), f13(xVec);
%                  f21(xVec), f22(xVec), f23(xVec);
%                  f31(xVec), f32(xVec), f33(xVec)];

% grMat=@(xVec) [f1(xVec); f2(xVec); f3(xVec)];

%-------------
% f4=@(xVec)  0;
% 
% 
% f14=@(xVec) 0;
% f24=@(xVec) 0;
% f34=@(xVec) 0;
% 
% f41=@(xVec) 0;
% f42=@(xVec) 0;
% f43=@(xVec) 0;
% f44=@(xVec) 0;

% HMat=@(xVec) [   f11(xVec), f12(xVec), f13(xVec), f14(xVec);
%                  f21(xVec), f22(xVec), f23(xVec), f24(xVec);
%                  f31(xVec), f32(xVec), f33(xVec), f34(xVec);
%                  f41(xVec), f42(xVec), f43(xVec), f44(xVec)];

% grMat=@(xVec) [f1(xVec); f2(xVec); f3(xVec); f4(xVec) ];

%------------

format long; 

f1var=@(xVec) (xVec(1)^2)*(sin(xVec(1))^2);

%f1var=@(xVec) xVec.^2;

%f2var=@(xVec) (xVec(1)^2).*(sin(xVec(1))^2)+(xVec(2)^2)*(sin(xVec(2))^2);
 
xCurVec=2.8;
HCurMat=HMat(xCurVec);
grCurVec=grVec(xCurVec);
xIterVec=[xCurVec];

while (norm(grVec(xCurVec))>0.0000000001)
    
    
    %disp(xCurVec);
    HCurMat=HMat(xCurVec);% f1=@(xVec) (2*xVec(1))*(sin(xVec(1))).^2+sin(2*xVec(1)).*((xVec(1)).^2);
% 
% 
% f11=@(xVec) 4*xVec(1)*sin(2*xVec(1))+2*(sin(xVec(1))).^2+2*(xVec(1).^2).*cos(2*xVec(1));

    disp(['H ',num2str(HCurMat)]);
    HinvMat=inv(HCurMat);
	disp(['H inv ',num2str(HinvMat)]);
    grCurVec=grVec(xCurVec);
    disp(['Gr ',num2str(grCurVec)]);
    
    xCurVec=xCurVec-HinvMat*grCurVec;
    xIterVec=cat(2,xIterVec,xCurVec);
    %disp(eig(HCurMat));
        
end
    
    
    
disp('MyAnswer: ');
disp(xCurVec);

if size(xCurVec,1)==1
    disp('fminbnd Answer: ');
    if xIterVec(1)<xCurVec
        disp(fminbnd(f1var,xIterVec(1),xCurVec));
    else
        disp(fminbnd(f1var,xCurVec,xIterVec(1)));
    end
    
    plF=@(xVec) (xVec.^2).*(sin(xVec).^2);

    %plF=@(xVec) (xVec.^2);

    xVec=-5:0.01:5;
    plot(xVec,plF(xVec));

    hold on;
    plot(xIterVec,plF(xIterVec));
    hold off;

else
    
    f=@(xMat,yMat) (xMat.^2).*(sin(xMat.^2))+(yMat.^2).*(sin(yMat).^2);
    plF2=@(xVec,yVec) (xVec.^2).*(sin(xVec.^2))+(yVec.^2).*(sin(yVec.^2));

    xVec=-5:0.2:5;
    yVec=xVec;
    [xMat,yMat]=meshgrid(xVec,yVec);
    zMat=f(xMat,yMat);

    surf(xMat,yMat,zMat);
    hold on;
    zIterVec=plF2(xIterVec(1,:),xIterVec(2,:));
    plot3(xIterVec(1,:),xIterVec(2,:),zIterVec,'r*');
    for k=1:size(zIterVec,2)
        contour3(xMat,yMat,zMat,[zIterVec(k) zIterVec(k)],'r');
    end
    hold off;
     
end


