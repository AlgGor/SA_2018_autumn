function resVec=getequal(f,g,t0,t1,N)
    
    tVec=linspace(t0,t1,N*10);
    
    xVec=f(tVec);
    xDistVec=diff(xVec);
    
    yVec=g(tVec);
    yDistVec=diff(yVec);
    
    averDist=sum(sqrt(xDistVec.^2+yDistVec.^2))/N;    
    curSum=1;
    resVec=nan(1,N);
    resInd=1;
    
    for k=1:(N*10-1)
        curSum=curSum+sqrt(xDistVec(k)^2+yDistVec(k)^2);
        if curSum>=averDist
            resVec(resInd)=tVec(k);
            resInd=resInd+1;
            curSum=0;
        end
    end
    resVec(end)=tVec(N*10);    
    
end

%     t0Vec=((t1-t0)/N)*ones(1,N+1);
%     eqN=N+1;
%     function distVec=dist(tVec)
%         myDist=@(k) sqrt( (f(tVec(k-1))-f(tVec(k)))^2 + (g(tVec(k-1))-g(tVec(k)))^2);
%         distVec=1:eqN;
%         for k=2:(eqN-1)
%             distVec(k)=myDist(k)-tVec(eqN);
%         end
%         distVec(1)=tVec(1)-t0;
%         distVec(eqN)=tVec(eqN-1)-t1;
%     end 
% 
%     options=optimoptions('fsolve','MaxFunctionEvaluations',10000000,'MaxIterations',100000);
%     func=@dist;
%     xVec=fsolve(func,t0Vec,options);
%     disp(xVec);
