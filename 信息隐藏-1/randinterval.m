function [x,y]=randinterval(data,length,key)

    
    rand('seed',key);
    a=rand(length);

    [m,n]=size(data);
    interval1=floor(m*n/length)+1;
    interval2=interval1-2;
    if interval2==0
         error("载体过小");
    end
    x=zeros(1,length);
    y=zeros(1,length);

    tx=1;
    ty=1;

    x(1)=tx;
    y(1)=ty;

    for i=2:length
        
        if a(i)>0.5
            ty=ty+interval1;
        else
            ty=ty+interval2;
        end
        
        if ty>n
            tx=tx+1;
            if tx>m
                error("载体过小");
            end
        end 
        ty=mod(ty,n);
        if ty==0
            ty=1;
        end
            x(i)=tx;
            y(i)=ty;
    end
end