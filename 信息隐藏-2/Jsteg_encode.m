function [origin_data,m_data,site]=Jsteg_encode(imgpath,filepath)
fid=fopen(filepath,'r');
[A,B]=fread(fid,'ubit1');
fclose(fid);
tA=A;
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
[h,w]=size(data);
D=zeros(h,w);       %零时存储矩阵
for i=1:h/8
    for j=1:w/8
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=dct2(data(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=round(D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)./Q);
    end
end

[X,Y]=find_site(D,B);
site=[X;Y];

for v=1:B
    x=X(v);
    y=Y(v);
    D(x,y)=insert(D(x,y),A(v));
end


for i=1:h/8
    for j=1:w/8
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=D(8*(i-1)+1:8*i,8*(j-1)+1:8*j).*Q;
        D(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=idct2(D(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
    end
end


D=uint8(D);
m_data=D;
imshow(m_data);
end



