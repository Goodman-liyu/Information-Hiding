function [r,resultString]=b_extract(data,R0,R1,key,lamda,count)
    [m,n]=size(data);
    m=floor(m/10);
    n=floor(n/10);

    temp=zeros([m,n]);
    [row,col]=hashreplacement(temp,m*n,m,key,n);
    for i=1:m*n
        if row(i)~=1
                row(i)=(row(i)-1)*10+1;
        end

        if col(i)~=1
                col(i)=(col(i)-1)*10+1;
        end
    end
    quan=1;
    r=zeros(1,count);
    for i=1:m*n
        p1bi=compute_p1bi(row(i),col(i),data);
        %if p1bi<R1+3*lamda &&p1bi>50
        if p1bi<=R1+lamda &&p1bi>=R1
            r(quan)=1;
            quan=quan+1;
        %elseif p1bi>R0-3*lamda &&p1bi<50
         elseif p1bi>=R0-lamda &&p1bi<=R0
            r(quan)=0;
            quan=quan+1;
        else
            quan=quan;
        end
        if quan==count+1
            break;
        end
    end

     resultString = '';

    for i = 1:8:count
    eightBits = r(i:i+7);  % 获取下一个8位的二进制序列
    decimalValue = bin2dec(num2str(eightBits));  % 将二进制转换为十进制
    character = char(decimalValue);  % 将十进制转换为ASCII字符
    resultString = [resultString, character];  % 将字符添加到结果字符串
    end


end