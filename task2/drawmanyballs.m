function drawmanyballs(alphas, colors, params)
    nAlphas=size(alphas,2);
    disp(nAlphas);
    paramInFunc=struct('FaceColour','blue','EdgeColour','green','FaceAlpha',0.5,'manyBalls','on');
    for k=1:nAlphas
          paramsInFunc.FaceColour=colors(k);
          paramInFunc.EdgeColour=params(k);
          drawball(alphas(k),paramInFunc);
    end
end