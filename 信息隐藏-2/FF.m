function [v]=FF(temp,M)

    for i=1:4
        if M(i)==1
            t=mod(temp(i),2);
            if t==0
            temp(i)=temp(i)+1;
            else 
            temp(i)=temp(i)-1;
            end
        elseif  M(i)==-1
            t=mod(temp(i),2);
            if t==0
            temp(i)=max(temp(i)-1,0);
            else 
            temp(i)=min(temp(i)+1,255);
            end
            
        end
    end
    v=temp;
end