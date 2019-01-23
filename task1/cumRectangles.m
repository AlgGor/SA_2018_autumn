function CumRect=cumRectangles(xVec, yVec)
    CumRect= cumsum( [0,diff(xVec).*yVec(1,2:size(yVec,2)) ],2);
end