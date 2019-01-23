function  compareinterp( xVec, xQueryVec, func )

    subplot(2,2,1);
    yQueryVec=interp1(xVec,func(xVec),xQueryVec,'linear'); 
    plot(xVec,func(xVec),'o',xQueryVec,yQueryVec,'g',xQueryVec,func(xQueryVec),'r:.');
    legend('initial','query','original'); 
    axis([ 0.9*min(xVec) 1.2*max(xVec) 0.9*min(func(xQueryVec)) 1.3*max(func(xQueryVec)) ]);
    title('Subplot 1: Linear');
    
   
    subplot(2,2,2);
    yQueryVec=interp1(xVec,func(xVec),xQueryVec,'nearest');
    plot(xVec,func(xVec),'o',xQueryVec,yQueryVec,'g',xQueryVec,func(xQueryVec),'r:.');
    legend('initial','query','original');
    axis([ 0.9*min(xVec) 1.2*max(xVec) 0.9*min(func(xQueryVec)) 1.3*max(func(xQueryVec)) ]);
    title('Subplot 2: Nearest');

    subplot(2,2,3);
    yQueryVec=interp1(xVec,func(xVec),xQueryVec,'spilne');    
    plot(xVec,func(xVec),'o',xQueryVec,yQueryVec,'g',xQueryVec,func(xQueryVec),'r:.');
    legend('initial','query','original');
    axis([ 0.9*min(xVec) 1.2*max(xVec) 0.9*min(func(xQueryVec)) 1.3*max(func(xQueryVec)) ]);
    title('Subplot 3: Spline');
    
    subplot(2,2,4);
    yQueryVec=interp1(xVec,func(xVec),xQueryVec,'cubic');
    plot(xVec,func(xVec),'o',xQueryVec,yQueryVec,'g',xQueryVec,func(xQueryVec),'r:.');
    legend('initial','query','original');
    axis([ 0.9*min(xVec) 1.2*max(xVec) 0.9*min(func(xQueryVec)) 1.3*max(func(xQueryVec)) ]);
    title('Subplot 4: Cubic');
end