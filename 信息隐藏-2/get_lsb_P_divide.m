function [res]=get_lsb_P_divide(divide_data,number)
    res=zeros(1,number);
    for i=1:number
        temp=squeeze(divide_data(i,:,:));
        [count] =get_count(temp);
        [p]=get_lsb_P(count);
        res(i)=p;
    end

end