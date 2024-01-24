function [splite_data]=divide(data,num)

    [m,n]=size(data);
    tn=floor(n/num);
    splite_data=zeros(num,m,tn);
    sy=1;
    ey=tn;
    for i=1:num
        splite_data(i,:,:)=data(:,sy:ey);
        sy=sy+tn;
        ey=ey+tn;
    end
end