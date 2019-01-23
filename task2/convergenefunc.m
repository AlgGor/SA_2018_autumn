function convergenefunc(fn,f,a,b,nFrames,convType)
    
    mov(1:nFrames) = struct('cdata', [],'colormap', []);
    switch convType
        case 'rms'
            xVec= linspace(a,b);
        otherwise
            xVec=linspace(a,b,1000);
    end
    
    switch convType
        case 'point'
            for i = 1:nFrames
                plot(xVec, fn(xVec,i),xVec,f(xVec));
                mov(i) = getframe();
            end
        case 'uniform'
            for i = 1:nFrames
                fnValVec=fn(xVec,i);
                fValVec=f(xVec);
                plot(xVec, fnValVec,xVec,fValVec);
                title(['Metrics uniform: ',num2str( max( abs( fn(xVec,i)-f(xVec) ) )),' ',num2str(i)]);
                mov(i) = getframe();
            end   
        case 'rms'
            for i = 1:nFrames
                fnValVec=fn(xVec,i);
                fValVec=f(xVec);
                plot(xVec, fnValVec,xVec,fValVec);        
                axis([0.1 1 0 2]);
                
                title(['Metrics rms: ',num2str( sqrt(trapz(xVec,(fValVec-fnValVec)).^2 ) ),' ',num2str(i)]);
                %pause(1);
                mov(i) = getframe();
            end
        otherwise
           error('Incorrect flag!');
    end
    
    
    switch convType
        case 'rms'
            movie(mov,1,1);
        otherwise
            movie(mov,1,3);
    end
   
    
    clear;
end
