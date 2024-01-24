function [count]=get_count(data)
    
    [m,n]=size(data);
    count=zeros(1,256);
    for i=1:m
        for j=1:n
        pixel=data(i,j);
        
        count(pixel+1)= count(pixel+1)+1;  %1-256对应着0-255像素值
        end
    end
end