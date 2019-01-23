function drawball(alpha,params)

    figure(2);
    if strcmp(params.manyBalls,'off')
        cla(gcf);
        nPoints=params.nPoints;
        nInDim=ceil(nPoints^(1/3));
        faceColour=params.FaceColour;
        edgeColour=params.EdgeColour;
        faceAlpha=params.FaceAlpha;
        maxCoord=5+randi(5);
        disp(['Max Coord: ', num2str(maxCoord)]);
        dist=(2*maxCoord/nInDim);
        disp(['Dist: ', num2str(dist)]);
        xVec=-maxCoord:dist:maxCoord;
        yVec=xVec;
        zVec=xVec;
        [xMat,yMat,zMat]=meshgrid(xVec,yVec,zVec);
    else    
        faceColour=params.FaceColour;
        edgeColour=params.EdgeColour;
        faceAlpha=params.FaceAlpha;
        maxCoord=10;
        xVec=-10:0.2:10;
        yVec=xVec;
        zVec=xVec;
        [xMat,yMat,zMat]=meshgrid(xVec,yVec,zVec);
    end
    
    
    fNotInfAlpha=@(xMat,yMat,zMat,alpha) abs(xMat).^(alpha)+abs(yMat).^(alpha)+abs(zMat).^(alpha);
    fInfAlpha=@(xFiMat,yFiMat,zFiMat) max(fi(max(xFiMat,yFiMat)),zMat);
    
    if alpha==inf
        xFiMat=abs(fi(xMat));
        yFiMat=abs(fi(yMat));
        zFiMat=abs(fi(zMat));
        fMat=fInfAlpha(xFiMat,yFiMat,zFiMat);
        val=3+(maxCoord-3)*rand;
    else
        fMat=fNotInfAlpha(xMat,yMat,zMat,alpha);
        val=(3+(maxCoord-3)*rand)^alpha;
    end
    
    disp(['Val: ', num2str(val)]);
    fv=isosurface(fMat,val);
    p=patch(fv,'FaceColor',faceColour,'EdgeColor',edgeColour,'FaceAlpha',faceAlpha);
    isonormals(fMat,p);
    view(3);
    daspect([1 1 1]);
    grid on;
    axis 'auto';
    if strcmp(params.manyBalls,'off')
        camlight;
    else
        if size(findobj(gcf,'Type','Light'),1)~=1  
            camlight;
        end
    end
    lighting gouraud;
    clear;
    
end