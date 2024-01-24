function [r,resultString]=dct_2_decode(data,key,B)

    data=double(data)/255;
    data=data(:,:,1);

    T=dctmtx(8);
    dctrgb=blkproc(data,[8 8],'P1*x*P2',T,T');
    [row,col]=size(dctrgb);
    row=floor(row/8);
    col=floor(col/8);
    a=zeros([row col]);
    [k1,k2]=randinterval(a,B,key);
    r=zeros(1,B);
    for i=1:B
        k1(i)=(k1(i)-1)*8+1;
        k2(i)=(k2(i)-1)*8+1;    
    end
   for i=1:B
        if dctrgb(k1(i)+4,k2(i)+1)<=dctrgb(k1(i)+3,k2(i)+2)
            r(i)=0;
        else
            r(i)=1;
        end
   end

    resultString = '';
    for i = 1:8:B
    eightBits = r(i:i+7);  % 获取下一个8位的二进制序列
    decimalValue = bin2dec(num2str(eightBits));  % 将二进制转换为十进制
    character = char(decimalValue);  % 将十进制转换为ASCII字符
    resultString = [resultString, character];  % 将字符添加到结果字符串
    end

end