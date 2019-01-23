function curFunc = getPnF(k,tVec)

     if k==0
         n=size(tVec,2);
         curFunc=@(tVec) ones(1,n);

     elseif k==1
         curFunc=@(tVec) tVec;

     else
         f1=getPnF(k-1,tVec);

         f2=getPnF(k-2,tVec);

         f3=@(tVec) tVec;

         curFunc=@(tVec) (2*k-1)*f3(tVec).*f1(tVec)/k-(k-1)*f2(tVec)/k;

     end

end
