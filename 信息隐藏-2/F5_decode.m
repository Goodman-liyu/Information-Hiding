function [r,r_ASCII]=F5_decode(data,length)
                       
r=zeros(1,8);

Q=[16 11 10 16 24 40 51 61
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
M=[0 0 0 1 1 1 1;
    0 1 1 0 0 1 1;
    1 0 1 0 1 0 1];


[h,w]=size(data);
D=zeros(h,w);       %零时存储矩阵
for i=1:h/8
    for j=1:w/8
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=dct2(data(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=round(D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)./Q);
    end
end

num=0;
a=zeros(7,1);
k=1;
jumpaway=0;

for i=1:h
    for j=1:w

        if (D(i,j)>0 && mod(D(i,j),2)) || (D(i,j)<0 && ~mod(D(i,j),2))
            a(k)=1;
            k=k+1;
        elseif (D(i,j)>0 && ~mod(D(i,j),2)) || (D(i,j)<0 && mod(D(i,j),2))
            a(k)=0;
            k=k+1;
        end
        if k>7  %表示集满7个数据
            temp=M*a;
            temp=mod(temp,2);
            for c=1:3
                num=num+1;
                r(num)=temp(c);
                if num==length
                    jumpaway=1;
                    break
                end
            end
            if jumpaway
                break;
            end
            k=1;
        end
       
    end
    if num>=length
        break;

    end
end



resultString = '';

for i = 1:8:length
    eightBits = r(i:i+7);  % 获取下一个8位的二进制序列
    decimalValue = bin2dec(num2str(eightBits));  % 将二进制转换为十进制
    character = char(decimalValue);  % 将十进制转换为ASCII字符
    resultString = [resultString, character];  % 将字符添加到结果字符串
end
r_ASCII=resultString;


end