function drawset(rho,N,param)
        
    alphaVec=1:N;
    alphaPiVec=alphaVec*2*pi/N;
    xVec=100*cos(alphaPiVec);
    yVec=100*sin(alphaPiVec);
    xSupVec=1:N;
    ySupVec=1:N;
    
    for k=1:N
       [~,point]=rho([xVec(k),yVec(k)]);
       xSupVec(k)=point(1);
       ySupVec(k)=point(2);
    end
    
    
    
    xExtVec=1:N;
    xLineVec=linspace(1.5*min(xSupVec),1.5*max(xSupVec),5);

    yExtVec=1:N;
    yLineVec=linspace(1.5*min(ySupVec),1.5*max(ySupVec),5);
    % for A*x1+B*x2+C=0 line
    curA=1;
    curB=1;
    curC=1;
    prevC=1;

    plot(xSupVec,ySupVec,'r',[xSupVec(N),xSupVec(1)],[ySupVec(N),ySupVec(1)],'r');

    downG=@(tVec) min(tVec)-1/2*(abs(min(tVec)));
    upG=@(tVec) max(tVec)+1/2*(abs(max(tVec)));
    axis([downG(xSupVec) upG(xSupVec) downG(ySupVec) upG(ySupVec)]);
    axis('equal');

    if strcmp(param,'on')
        
        hold on;
        
        curA=xVec(1);
        curB=yVec(1);
        curC=( (xSupVec(1))*curA + (ySupVec(1))*curB ); 
        
        curMat=[curA,curB];
        aMat=curMat;
        bVec=curC;
        
        for k=2:N
            
            curA=xVec(k);
            curB=yVec(k);
            curC=( (xSupVec(k))*curA+(ySupVec(k))*curB); 
            
            curMat=[zeros(1,size(aMat,2)-2),curA,curB];
            
            aMat=cat(1,aMat,curMat);
            
            aMat=cat(2,aMat,zeros(size(aMat,1),2));
            curMat=cat(2,zeros(1,2),curMat);
            
            aMat=cat(1,aMat,curMat);
            bVec=cat(1,bVec,curC,curC);
            
        end
        
        curA=xVec(1);
        curB=yVec(1);
        curC=( (xSupVec(1))*curA + (ySupVec(1))*curB); 
        
        curMat=[zeros(1,size(aMat,2)-2),curA,curB];
        aMat=cat(1,aMat,curMat);
        bVec=cat(1,bVec,curC);
        
       disp(aMat);
%         disp(bVec);
        
        resVec=aMat\bVec;
        xExtVec=resVec(1:2:size(resVec,1));
        yExtVec=resVec(2:2:size(resVec,1));
             
%         disp(xExtVec);
%         disp(yExtVec);
        
        plot(xExtVec,yExtVec,'b',[xExtVec(end),xExtVec(1)],[yExtVec(end),yExtVec(1)],'b');
        hold off;
        
    end
    
end