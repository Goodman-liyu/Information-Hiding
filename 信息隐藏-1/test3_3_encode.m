function [origin,r,site]=test3_3_encode(imgpath,filepath,key)
   
    fid=fopen(filepath,'r');
    [A,B]=fread(fid,'ubit1');
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

    fclose(fid);
   
    data=rgb2gray(imread(imgpath));
    origin=data;
    [m,n]=size(data);
    if B>m*n
        error("信息数量过长")
    end

    p=1;

    [x,y]=randinterval(data,B,key);
    for i=1:B

        data(x(i),y(i))=data(x(i),y(i))-mod(data(x(i),y(i)),2)+A(p);
        p=p+1;

    end

    data=uint8(data);
    
    subplot(1,2,1),imshow(origin);title("origin");
    subplot(1,2,2),imshow(data);title("modified")
    r=data;
    site=[x;y];

end