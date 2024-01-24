function [p]=get_lsb_P(count)
    
    X=0;
    k=0;
    for i=0:127
        a=2*i;
        b=2*i+1;
         %1-256对应着0-255像素值
        h_2i=count(a+1);
        h_2i1=count(b+1);
        h_2i_star=(h_2i+h_2i1)/2;
        if h_2i_star~=0
              X=X+(h_2i-h_2i_star)^2/h_2i_star;
              k=k+1;
        end   
    end
    p=1-chi2cdf(X,k);
end