function [r]=insert(v,b)
    r=v;
    if b==1

        if mod(r,2)
            return;
        else
            if r>0
                r=r+1;
            else
                r=r-1;
            end
        end

    else
    
        if mod(r,2)

            if r>0
                r=r-1;
            else
                r=r+1;
            end

        else
            return;
        end

    end

end