function viewpoints(pointsMat,ampl,level)
    
    figure(2);
    nPoints=size(pointsMat,1);
    distMax=ceil((ampl/level)-1)+2;
    
    if nPoints==1
        
        xCoord=pointsMat(1);
        yCoord=pointsMat(2);
        xVec=(xCoord-distMax):0.2:(xCoord+distMax);   
        yVec=(yCoord-distMax):0.2:(yCoord+distMax); 
        
    else
        
        maxCoordMat=max(pointsMat);
        minCoordMat=min(pointsMat);
        xMax=maxCoordMat(1)+nPoints*distMax;
        yMax=maxCoordMat(2)+nPoints*distMax;
        xMin=minCoordMat(1)-nPoints*distMax;
        yMin=minCoordMat(2)-nPoints*distMax;
        
        xVec=xMin:.2:xMax;   
        yVec=yMin:.2:yMax;  
    end   
    [xMat,yMat]=meshgrid(xVec,yVec);
            
    
    dist=@(xCur,yCur) ((xMat-xCur).^2+(yMat-yCur).^2).^(1/2);
    zMat=(ampl*((1+dist(pointsMat(1,1),pointsMat(1,2))).^(-1)));
    for i=2:nPoints
        xCur=pointsMat(i,1);
        yCur=pointsMat(i,2);
        zMat=zMat+(ampl*((1+dist(xCur,yCur)).^(-1)));
    end
    s=surf(xMat,yMat,zMat);
    s.EdgeColor='none';
    figure(3);
   
    [C,~]=contourf(xMat,yMat,zMat,[level,level]);
     
    if (size(C,2)-1)>C(2,1)
        disp('False');
    else 
        disp('True');
    end
    
    clear;
end