 function fourierapprox(f,a,b,nFrames,meth)

    mov(1:nFrames) = struct('cdata', [],'colormap', []);

    switch meth
        case 'trig'
            
            l=pi;
            
            getCos=@(n,tVec) cos(n*tVec);
            getSin=@(n,tVec) sin(n*tVec);
            
            xVec=linspace(a,b,25*floor(b-a));
            tVec=linspace(-l,l,25*floor(b-a));
            
            sum=(1/pi)/2*integral(@(t) f((t*(b-a)/pi+(a+b))/2),-l,l);
            aN=1;
            bN=1;
            curCosVec=tVec;
            curSinVec=tVec;
            for k = 1:nFrames
                curCosVec=getCos(k,tVec);
                curSinVec=getSin(k,tVec);
                aN=(1/l)*integral(@(t) f((t*(b-a)/pi+(a+b))/2).*getCos(k,t),-l,l); 
                bN=(1/l)*integral(@(t) f((t*(b-a)/pi+(a+b))/2).*getSin(k,t),-l,l);
                sum=sum+aN.*curCosVec+bN.*curSinVec;
                plot(xVec,sum);
                title(num2str(k));
                
                mov(k) = getframe();
            end
            
        case 'polyn'  
                        
            l=1;
            
            getTn=@(n,tVec) cos(n*acos(tVec));
            
            xVec=linspace(a,b,100*floor(b-a));
            tVec=linspace(-l,l,100*floor(b-a));
            
            weightFuncVec=@(tVec) 1./sqrt((1+(-1)*(tVec.^2)));
           
            sum=(2/pi)*integral(@(t) weightFuncVec(t).*f((t*(b-a)+(a+b))/2),-l,l);
            
            cN=1;
            curTnVec=tVec;
            
            for k = 1:nFrames
                curTnVec=getTn(k,tVec);
                fun=@(t) (weightFuncVec(t).*f((t*(b-a)+(a+b))/2)).*getTn(k,t);
                cN=(2/pi)*integral(@(t) fun(t),-l,l);
                sum=sum+cN.*curTnVec;
                plot(xVec,sum);
                title(num2str(k));
                mov(k) = getframe();
            end  
            
        case 'legen'
            
            l=1;
            
            xVec=linspace(a,b,100*floor(b-a));
            tVec=linspace(-l,l,100*floor(b-a));
            
            sum=(1/2)*integral(@(t) f((t*(b-a)+(a+b))/2),-l,l);
           
            sum=sum+ tVec*3/2*integral(@(t) t.*f((t*(b-a)+(a+b))/2),-l,l);
            
            disp(sum(1));
            
            fun=@(tVec) f((tVec*(b-a)+(a+b))/2);
%             valVec=fun(tVec);
%             disp('Preobr');
%             disp(valVec(1));
%             disp('Original');
%             valVecVec=f(xVec);
%             disp(valVecVec(1));
           
            for k = 2:nFrames
                               
                curPn=getPnF(k,tVec);
%                 if k==5
%                     disp('Orig');
%                     fO=@(xVec) 1/8*(63*xVec.^5-70*xVec.^3+15*xVec);
%                     disp(fO(tVec));
%                     disp('My');
%                     disp(curPn(tVec));
%                     pause(5);
%                 end
                
                   
                interFunc=@(tVec) fun(tVec).*curPn(tVec);
               
                val=interFunc(tVec);
                %disp(val(1));
                aN=((2*k+1)/2)*trapz(tVec,interFunc(tVec));
               %disp(aN);
                sum=sum+aN.*curPn(tVec);
                plot(xVec,sum);
               
                %axis([min(xVec) max(xVec) min(sum)-10 max(sum)+10]);
                title(num2str(k));
                %pause(2);
                mov(k) = getframe();
                
            end  
            
        otherwise
            error('Incorrect meth');
    end
    %movie(mov,1,5);
    clear;
end

