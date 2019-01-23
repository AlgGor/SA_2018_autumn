%% The first block
clear;
x=-10:0.2:10;
y=-10:0.2:10;

[xVec,yVec] = meshgrid(x,y);
paramVec=0.5:0.05:1.5;
f=@(xVec,yVec,param) sin(xVec/param)+cos(yVec/(2*param));

%% The second block
figure(2);
nFrames=size(paramVec,2);
mov(1:nFrames) = struct('cdata', [],'colormap', []);

for i=1:nFrames
    curParam=paramVec(i);
    
    zMat=f(xVec,yVec,curParam);
    minZMat=zMat.*imregionalmin(zMat,6);
    maxZMat=zMat.*imregionalmax(zMat,6);
    minZMat(find(minZMat==0))=nan;
    maxZMat(find(maxZMat==0))=nan;
    surf(xVec,yVec,zMat)
    hold on;
    plot3(xVec,yVec,minZMat,'d');
    plot3(xVec,yVec,maxZMat,'d');     
    hold off;
    mov(i)=getframe(); 
end       

%% The third block
movie(mov,1,3);

%% The fourth block
randFrame=randi(nFrames);
zMat=f(xVec,yVec,paramVec(randFrame));
zMin=min(min(zMat));
zMax=max(max(zMat));
zLevel=zMin+rand*(abs(zMin)+abs(zMax));
contourf(xVec,yVec,zMat,[0.5 0.5]);

%% The fifth block
save('TheThirdPartMovie','mov');

%% The sixteenth block

axis;
set(gca,'nextplot','replacechildren'); 
v = VideoWriter('Avi_Movie','Motion JPEG AVI');
open(v);
for i=1:nFrames
     curParam=paramVec(i);
    
    zMat=f(xVec,yVec,curParam);
    minZMat=zMat.*imregionalmin(zMat,6);
    maxZMat=zMat.*imregionalmax(zMat,6);
    minZMat(find(minZMat==0))=nan;
    maxZMat(find(maxZMat==0))=nan;
    surf(xVec,yVec,zMat)
    hold on;
    plot3(xVec,yVec,minZMat,'d');
    plot3(xVec,yVec,maxZMat,'d');     
    hold off;
    frame = getframe(gcf);
    writeVideo(v,frame);   
end

close(v);

%% Video player
v=VideoReader('Avi_Movie.avi');
currAxes = axes;
while hasFrame(v)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/v.FrameRate);
end
