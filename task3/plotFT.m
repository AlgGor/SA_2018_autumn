function res=plotFT(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)
    format longE;
    res=struct('nPoints',[],'step',[], 'inpLimVec',[],'outLimVec',outLimVec);

    disp(' ');
    disp(' ');
    disp('New: ');
    disp(' ');
    
    a = inpLimVec(1);
    b = inpLimVec(2);
    n = floor((b - a)./step)+1;
    disp(['Число точек: ',num2str(n)]);
   
    step = (b - a)./(n - 1);
    disp(['Шаг: ',num2str(step)]);
    offset=floor(a/step);%%-floor(n/2);
    disp(['Смещение: ',num2str(offset)]);
    
    res.step = step;
    
    tVec=linspace(inpLimVec(1),inpLimVec(2),n);
    
    pos=abs(offset);
    disp(tVec(pos));
    disp(tVec(pos+1));
    if abs(tVec(pos))>abs(tVec(pos+1))
        shift=tVec(pos+1);
    else
        shift=tVec(pos);
        offset=offset+1;
    end
    
    disp(shift);
    
    tVec=tVec-sign(shift)*abs(shift);

    res.inpLimVec=[tVec(1),tVec(end)];
    
    func=circshift(fHandle(tVec),offset);
    
    res.nPoints = n;
     
    funcTrans=step.*fftshift(fft(func));
    
    hVec=linspace(-pi/step,pi/step,n); 
    
    SPlotInfo=get(hFigure,'UserData');
        
    if isempty(SPlotInfo)
        if isempty(outLimVec)
            disp('empty outLimVec');
            res.outLimVec = [hVec(find(abs(funcTrans)>0.01,1)),hVec(find(abs(funcTrans)>0.01,1,'last'))];
            outLimVec=res.outLimVec;
        end
        
        clf(hFigure);
        
        axRe=subplot(2,1,1);
        set(axRe,'XLim', outLimVec);
        axRe.Title.String = 'Real part';
        axRe.Title.FontSize=30;
        axRe.XLabel.String = 'h';
        axRe.XLabel.FontSize=30;
        axRe.YLabel.String = 'Re F(h)';
        axRe.YLabel.FontSize=30;
               
        axIm = subplot(2, 1, 2);
        set(axIm, 'XLim', res.outLimVec);
        axIm.Title.String = 'Imaginary part';
        axIm.Title.FontSize=30;
        axIm.XLabel.String = 'h';
        axIm.XLabel.FontSize=30;
        axIm.YLabel.String = 'Im F(h)';
        axIm.YLabel.FontSize=30;
        
        SPlotInfo = struct('axRe', axRe, 'axIm', axIm);
        
    end
    
    if ~isempty(outLimVec)
        set(SPlotInfo.axRe, 'XLim', res.outLimVec);
        axRe.FontSize=30;
        set(SPlotInfo.axIm, 'XLim', res.outLimVec);
        axIm.FontSize=30;
    end
       
    set(hFigure, 'UserData', SPlotInfo);
    
    hFigure.CurrentAxes=SPlotInfo.axRe;
    hFigure.CurrentAxes.NextPlot = 'replacechildren';   
    p1=plot( hVec, real(funcTrans),'b');
    legend(p1,'Re F(h)');
    
%    hFigure.CurrentAxes.NextPlot = 'add';
%    plot( hVec+2*pi/step, real(funcTrans),'b',hVec-2*pi/step, real(funcTrans), 'b');
    
    if ~isempty(fFTHandle)
        
%        hVec=linspace(-6*pi/step,6*pi/step,6*n); 
        hFigure.CurrentAxes.NextPlot = 'add';
        p2=plot(hVec, real(fFTHandle(hVec)), '--r');
        
%         plot(hVec-2*pi/step, real(fFTHandle(hVec)), '--r');
%         plot(hVec+2*pi/step, real(fFTHandle(hVec)), '--r');
        
        
        legend([p1,p2],'Re F(h)', 'Re analytical FT');
        
    end   
        
    hVec=linspace(-pi/step,pi/step,n); 
    
    hFigure.CurrentAxes = SPlotInfo.axIm;
    hFigure.CurrentAxes.NextPlot = 'replacechildren';
    p3=plot(hVec, imag(funcTrans),'b');
    legend('Im F(h)');
   
%     hFigure.CurrentAxes.NextPlot = 'add';
%     plot( hVec+2*pi/step, imag(funcTrans),'b',hVec-2*pi/step, imag(funcTrans), 'b');
     
    if ~isempty(fFTHandle)
       
%         hVec=linspace(-6*pi/step,6*pi/step,6*n);  
        
        hFigure.CurrentAxes.NextPlot = 'add';
        p4=plot(hVec, imag(fFTHandle(hVec)), '--r');
         
%         plot(hVec+2*pi/step, imag(fFTHandle(hVec)), 'r');
%         plot(hVec-2*pi/step, imag(fFTHandle(hVec)), 'r');
     
        legend([p3,p4],'Im F(h)', 'Im analytical FT');
        
    end   
end