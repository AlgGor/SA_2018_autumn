function res=inv_matlab(aMat)

    if size(aMat,2)~=size(aMat,1)
        error('Number of columns and raws must be the same.');
    end
    if det(aMat)==0
        error('Inv matrix doesn`t exit for this input');
    end    
    eMat=eye(size(aMat,2));
    inpCopy=aMat;
    for step=1:size(inpCopy,2)-1
        for k=step+1:size(inpCopy,1)
            if inpCopy(step,step)~=0
                cur_mult=inpCopy(k,step)/inpCopy(step,step);
                for l=1:size(inpCopy,2)
                    inpCopy(k,l)=inpCopy(k,l)-inpCopy(step,l)*cur_mult;
                    eMat(k,l)=eMat(k,l)-eMat(step,l)*cur_mult;
                end
            else
                main_str=step;
                for s=step:size(inpCopy,1)
                  if inpCopy(s,step)~=0
                      main_str=s;
                  end
                end
                buff1=1:size(inpCopy,2);
                buff2=buff1;
                for s=1:size(inpCopy,2)
                    buff1(s)=inpCopy(step,s);
                    buff2(s)=eMat(step,s);
                    inpCopy(step,s)=inpCopy(main_str,s);
                    eMat(step,s)=eMat(main_str,s);
                    inpCopy(main_str,s)=buff1(s);
                    eMat(main_str,s)=buff2(s);
                end 
                cur_mult=inpCopy(k,step)/inpCopy(step,step);
                for l=1:size(inpCopy,2)
                    inpCopy(k,l)=inpCopy(k,l)-inpCopy(step,l)*cur_mult;
                    eMat(k,l)=eMat(k,l)-eMat(step,l)*cur_mult;
                end
            end
        end
    end
    %disp('MatLab aMat:');
    %disp(inpCopy);
    %disp('eMat matlab');
    %disp(eMat);
    for step=1:size(inpCopy,2)-1
        inv_step=size(inpCopy,2)-step+1;
        for k=inv_step-1:-1:1
           if inpCopy(inv_step,inv_step)~=0
               cur_mult=inpCopy(k,inv_step)/inpCopy(inv_step,inv_step);
               for l=1:size(inpCopy,2)
                    inpCopy(k,l)=inpCopy(k,l)-inpCopy(inv_step,l)*cur_mult;
                    eMat(k,l)=eMat(k,l)-eMat(inv_step,l)*cur_mult;
               end
           else
                main_str=inv_step;
                for s=inv_step:-1:1
                  if inpCopy(s,inv_step)~=0
                      main_str=s;
                  end
                end
                buff1=1:size(inpCopy,2);
                buff2=buff1;
                for s=1:size(inpCopy,2)
                    buff1(s)=inpCopy(inv_step,s);
                    buff2(s)=eMat(inv_step,s);
                    inpCopy(inv_step,s)=inpCopy(main_str,s);
                    eMat(inv_step,s)=eMat(main_str,s);
                    inpCopy(main_str,s)=buff1(s);
                    eMat(main_str,s)=buff2(s);
                end 
                cur_mult=inpCopy(k,inv_step)/inpCopy(inv_step,inv_step);
                for l=1:size(aMat,2)
                    aMat(k,l)=inpCopy(k,l)-inpCopy(inv_step,l)*cur_mult;
                    eMat(k,l)=eMat(k,l)-eMat(inv_step,l)*cur_mult;
                end
               
           end
        end
    end
    for k=1:size(inpCopy,2)
        for l=1:size(inpCopy,2)
            eMat(k,l)=eMat(k,l)/inpCopy(k,k);
        end        
    end
    clear inpCopy;
    res=eMat;
    
end