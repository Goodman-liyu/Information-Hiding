function [r]=f(temp)
    r=abs(temp(1)-temp(2))+abs(temp(2)-temp(3))+abs(temp(3)-temp(4));
end