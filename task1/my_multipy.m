function mult=my_multipy(aMat,bMat)

    if size(aMat,1)~=size(bMat,2)
        error('Incorrect matices!');
        mult=nan;
    end

    multMat=zeros(size(aMat,2),size(bMat,1));
    sumScal=0;
    for k=1:size(aMat,2)
        for l=1:size(bMat,1)
            sumScalar=0;
            for r=1:size(aMat,1)
                sumScalar=sumScalar+aMat(k,r)*bMat(r,l);
            end
            multMat(k,l)=sumScalar;
        end
    end
    
    mult=multMat;

end