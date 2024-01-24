function [p]=rs(data,M)
    R=zeros(2,4);
    [data_M,num]=split_data(data);
    for i=1:num
        temp=data_M(i,:);
        value=f(temp);
        value1=f(FF(temp,M));
        if value1>value 
            R(1,1)=R(1,1)+1;
        elseif value1<value 
            R(1,2)=R(1,2)+1;
        end
        
        value1=f(FF(temp,-M));
        if value1>value 
            R(1,3)=R(1,3)+1;
        elseif value1<value 
            R(1,4)=R(1,4)+1;
        end

    end
    
   
    for i=1:num
        temp=data_M(i,:);
        temp=bitxor(temp,1);
        value=f(temp);
        value1=f(FF(temp,M));
        if value1>value 
            R(2,1)=R(2,1)+1;
        elseif value1<value 
            R(2,2)=R(2,2)+1;
        end
        
        value1=f(FF(temp,-M));
        if value1>value 
            R(2,3)=R(2,3)+1;
        elseif value1<value 
            R(2,4)=R(2,4)+1;
        end

    end

    d_0=R(1,1)-R(1,2);
    d_1=R(2,1)-R(2,2);
    d_00=R(1,3)-R(1,4);
    d_11=R(2,3)-R(2,4);

    syms x
    equation=2*(d_1+d_0)*x^2+(d_00-d_11-d_1-3*d_0)*x+d_0-d_00==0;
    solution=solve(equation,x);
    x1=double(solution(1));
    x2=double(solution(2));
    if abs(x1)>abs(x2)
        px=x2;
    else
        px=x1;
    end
    p=px/(px-0.5);
    if p<0
        p=0;
    end
end