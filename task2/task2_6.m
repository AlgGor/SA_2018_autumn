%% The first block
clear;
n=1000;
xVec=linspace(1,20,n+1);
a=-1;
func=@(x) x.*sin(x);


%% The second block
    
[vMinVec,xIndVec]=findpeaks(-func(xVec),1:(n+1));
%disp('xIndVec: ');
%disp(xIndVec);
[vMinVec,xMinVec]=findpeaks(-func(xVec),xVec);
%disp('f(xVec): ');
%disp(func(xVec));
[vMax,indMax]= max(func(xVec));
%disp('IndMax: ');
%disp(indMax);
[dist,indMinDist]=min(abs(xIndVec-indMax));
%disp('dist: ');
%disp(dist);
%disp('qMinInd: ');
qMinInd=xIndVec(indMinDist);
%disp(qMinInd);

plot(xVec,func(xVec),xMinVec,-vMinVec,'o',xVec(indMax),vMax,'*');

hold on;
if indMax<qMinInd
    comet(xVec(indMax:qMinInd),func(xVec(indMax:qMinInd)));   
else
    comet(fliplr(xVec(qMinInd:indMax)),fliplr(func(xVec(qMinInd:indMax))));
end
hold off;

