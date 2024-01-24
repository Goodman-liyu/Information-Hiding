function [r,r_ASCII]=F4_decode(data,site,goalfile)
    fid=fopen(goalfile,'w');
[a,length]=size(site);
r=zeros(1,length);

Q=[16 11 10 16 24 40 51 61
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
[h,w]=size(data);
D=zeros(h,w);       %零时存储矩阵
for i=1:h/8
    for j=1:w/8
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=dct2(data(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=round(D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)./Q);
    end
end



for i=1:length

    x=site(1,i);
    y=site(2,i);
    if (D(x,y)>0 && mod(D(x,y),2)) || (D(x,y)<0 && ~mod(D(x,y),2))
        fwrite(fid,1,'bit1');
        r(i)=1;
    elseif (D(x,y)>0 && ~mod(D(x,y),2)) || (D(x,y)<0 && mod(D(x,y),2))
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
r_ASCII=resultString;


end