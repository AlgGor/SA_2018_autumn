function res=secondFFT(tVec)
    res= (exp(-abs(tVec))-1)./tVec;
    res(find(isnan(res)))=0;
    res(find(isinf(res)))=0;
    
end