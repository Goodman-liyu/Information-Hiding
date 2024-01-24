function [origin_data,m_data,length] = F5_encode(imgpath,txtpath,partition)
fid=fopen(txtpath,'r');
[A,B]=fread(fid,'ubit1');
fclose(fid);
tA=A;
length=B;
for i=1:8:B
    A(i)=tA(i+7);
    A(i+1)=tA(i+6);
    A(i+2)=tA(i+5);
    A(i+3)=tA(i+4);
    A(i+4)=tA(i+3);
    A(i+5)=tA(i+2);
    A(i+6)=tA(i+1);
    A(i+7)=tA(i);
end
B=round(B*partition);
data=rgb2gray(imread(imgpath));
origin_data=data;

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
    1 0 1 0 1 0 1];   %校验矩阵
[h,w]=size(data);
D=zeros(h,w);         
for i=1:h/8
    for j=1:w/8
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=dct2(data(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=round(D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)./Q);
    end
end

stego=D;
num=1;          %记录目前已经嵌入的data数量
a=zeros(7,1);
k=1;            %记录当前7个数值中已取数量
sit=zeros(7,2); %记录当前7个数在stego中的位置
for i=1:h
    for j=1:w
        if (D(i,j)>0 && mod(D(i,j),2)==1)||(D(i,j)<0 && mod(D(i,j),2)==0)        %正奇数或负偶数为1
            a(k)=1;
            sit(k,1)=i;
            sit(k,2)=j;
            k=k+1;
        elseif (D(i,j)<0 && mod(D(i,j),2)==1)||(D(i,j)>0 && mod(D(i,j),2)==0)    %负奇数或正偶数为0
            a(k)=0;
            sit(k,1)=i;
            sit(k,2)=j;
            k=k+1;
        end
        if(k>7)
            if B-num>=2
            data_bit=[A(num),A(num+1),A(num+2)]'; 
            elseif  B-num==1
            data_bit=[A(num),A(num+1),0]';    
            elseif B==num
            data_bit=[A(num),0,0]';    
            end

            temp=M*a;
            temp=mod(temp,2);
            n=bitxor(data_bit,temp);      %异或
            n=n(1)*4+n(2)*2+n(3);
            %% 修改第n位的DCT值
            if n>0      %需要修改，否则不需要修改 绝对值减一
                if D(sit(n,1),sit(n,2))<0
                    stego(sit(n,1),sit(n,2))=D(sit(n,1),sit(n,2))+1;
                elseif D(sit(n,1),sit(n,2))>0
                    stego(sit(n,1),sit(n,2))=D(sit(n,1),sit(n,2))-1;
                end
                %% 检查修改过后的DCT值是否为0，若为0则重新选择1位数据作为载体信号
                if stego(sit(n,1),sit(n,2))==0
                    k=k-1;
                    sit(n:k-1,:)=sit(n+1:k,:);
                    a(n:k-1)=a(n+1:k);
                    continue;
                end
            end
            num=num+3;
            k=1;
        end
        if(num>B)
            break;
        end
    end
    if(num>B)
        break;
    end
end
%% DCT转换，转换成伪装图像
for i=1:h/8
    for j=1:w/8
        stego(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=stego(8*(i-1)+1:8*i,8*(j-1)+1:8*j).*Q;
        stego(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=idct2(stego(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
    end
end
m_data=uint8(stego);