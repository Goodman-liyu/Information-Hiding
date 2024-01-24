function [r,resultString]=LSB_decode(data,site,goalfile)
  
    %data=double(data);
    fid=fopen(goalfile,'w');
    [a,length]=size(site);
    r=zeros(1,length);

    for i=1:length
        
        x=site(1,i);
        y=site(2,i);
        if bitand(data(x,y),1)==1
            fwrite(fid,1,'bit1');
            r(i)=1;
        else
            fwrite(fid,0,'bit1');
            r(i)=0;
        end

    end

    fclose(fid);

    resultString = '';

    for i = 1:8:length
    eightBits = r(i:i+7);  % 获取下一个8位的二进制序列
    decimalValue = bin2dec(num2str(eightBits));  % 将二进制转换为十进制
    character = char(decimalValue);  % 将十进制转换为ASCII字符
    resultString = [resultString, character];  % 将字符添加到结果字符串
    end

    


end