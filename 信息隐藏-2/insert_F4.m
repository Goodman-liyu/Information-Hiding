function [r,flag]=insert_F4(v,b)
r=v;
flag=0;
if b==1

    if (~mod(r,2)&&r<0) || (mod(r,2)&&r>=0)
        flag=1;
        return;
    elseif  ~mod(r,2)&&r>=0
        r=r-1;
        if r~=0
            flag=1;
        end
        return
    elseif   mod(r,2)&&r<0
        r=r+1;
        if r~=0
            flag=1;
        end
        return
    end

else

    if (~mod(r,2)&&r>=0) || (mod(r,2)&&r<0)
        flag=1;
        return;

    elseif ~mod(r,2)&&r<0
        r=r+1;
        if r~=0
            flag=1;
        end
        return
    elseif mod(r,2)&&r>=0
        r=r-1;
        if r~=0
            flag=1;
        end
        return
    end

end

end