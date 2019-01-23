function drawpolar(rho,N)
    

    drawset(rho,N,'off');
    
    hold on;
    
    alphaVec=1:N;
    alphaPiVec=alphaVec*2*pi/N;
    xVec=10*cos(alphaPiVec);
    yVec=10*sin(alphaPiVec);
    xSupVec=1:N;
    ySupVec=1:N;
    supFuncValVec=1:N;
    
    for k=1:N
       [val,point]=rho([xVec(k),yVec(k)]);
       xSupVec(k)=point(1);
       ySupVec(k)=point(2);
       xVec(k)=xVec(k)/abs(val);
       yVec(k)=yVec(k)/abs(val);
       supFuncVec(k)=val;
    end
    
%     disp('supFuncVec>=0');
%     disp(supFuncVec>=0);
    xVec(supFuncVec<0)=nan;
    yVec(supFuncVec<0)=nan;

    xNoZerosVec=xVec(isfinite(xVec));
    yNoZerosVec=yVec(isfinite(yVec));
    
    maxX=max(max(xVec),max(xSupVec));
    maxY=max(max(yVec),max(ySupVec));
    minX=min(min(xVec),min(xSupVec));
    minY=min(min(yVec),min(ySupVec));
      
    % here I find a type of the polar
    
    findY=@(val,xVec,yVec) yVec(xVec==val);
    findX=@(val,xVec,yVec) xVec(yVec==val);
    
    if max(xVec)>max(xSupVec)
        if  max(yVec)>max(ySupVec)
            xEdgeVec=[max(xVec),max(xVec),findX(max(yVec),xVec,yVec)];
            yEdgeVec=[max(yVec), findY(max(xVec),xVec,yVec),max(yVec)];           
        else
            xEdgeVec=[max(xVec),max(xVec),findX(min(yVec),xVec,yVec)];
            yEdgeVec=[min(yVec), findY(max(xVec),xVec,yVec),min(yVec)];   
        end
        ps=polyshape(xEdgeVec,yEdgeVec);
        pg=plot(ps);
        pg.FaceColor='b';
        pg.EdgeAlpha = 0;
    elseif min(xVec)<min(xSupVec)
        if  min(yVec)<min(ySupVec)
            xEdgeVec=[min(xVec),min(xVec),findX(min(yVec),xVec,yVec)];
            yEdgeVec=[min(yVec), findY(min(xVec),xVec,yVec),min(yVec)];   
        else
            xEdgeVec=[min(xVec),min(xVec),findX(max(yVec),xVec,yVec)];
            yEdgeVec=[max(yVec), findY(min(xVec),xVec,yVec),max(yVec)];   
        end  
        ps=polyshape(xEdgeVec,yEdgeVec);
        pg=plot(ps);
        pg.FaceColor='b';
        pg.EdgeAlpha = 0;
    end
    
    plot([xVec,xVec(1)],[yVec,yVec(1)],'g','LineWidth',2);
     
    ps=polyshape(xNoZerosVec,yNoZerosVec);
    pg=plot(ps);
    pg.FaceColor='b';
    pg.EdgeAlpha = 0;
    distX=(abs(maxX)+abs(minX))/2;
    distY=(abs(maxY)+abs(minY))/2;
    axis([minX-1/10*distX maxX+1/10*distX minY-1/10*distY maxY+1/10*distY]);
        
    hold off;
end