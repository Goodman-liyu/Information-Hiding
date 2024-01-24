function [data_M,num]=split_data(data)
    
    [m,n]=size(data);
    t1=floor(n/2);
    t2=floor(m/2);
    num=t1*t2;
    data_M=zeros(num,4);
    k=0;
  
    for i=1:2:m-2
        for j=1:2:n-2
            k=k+1;
            data_M(k,1)=data(i,j);
            data_M(k,2)=data(i,j+1);
            data_M(k,3)=data(i+1,j);
            data_M(k,4)=data(i+1,j+1);
        end
    end
end