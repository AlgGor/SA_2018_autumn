function res=thirdBlockFunc(x)
    
    if x<0
        error('Incorrect input');
    else    
        res=(sqrt(x)-tan(x));
    end
    
end