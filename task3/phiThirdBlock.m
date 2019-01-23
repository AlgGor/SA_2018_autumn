function res=phiThirdBlock(nVec)

    phi=@(nVec) 2./nVec;
    
    res=[2,phi(1:nVec(end))];

end