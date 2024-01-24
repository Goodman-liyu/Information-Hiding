function [origin,r,site]=LSBM_encode(imgpath,filepath,key,partition)
   
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
    B=round(B*partition);
    fclose(fid);
   
    data=rgb2gray(imread(imgpath));
    origin=data;
    [m,n]=size(data);
    if B>m*n
        error("信息数量过长")
    end

    p=1;

    %B为待嵌入bit信息长度，A数组中存放了待嵌入数据
    [x,y]=randinterval(data,B,key);
    for i=1:B   
        data_last=mod(data(x(i),y(i)),2);
        if data_last==A(p)
            p=p+1;
            continue;
        end
        if rand(1)>0.5
            data(x(i),y(i))=data(x(i),y(i))+1;
            if data(x(i),y(i))>255
                data(x(i),y(i))=255;
            end
        else
            data(x(i),y(i))=data(x(i),y(i))-1;
            if data(x(i),y(i))<0
                data(x(i),y(i))=0;
            end
        end
        p=p+1;
    end

    data=uint8(data);
    
    subplot(1,2,1),imshow(origin);title("origin");
    subplot(1,2,2),imshow(data);title("modified")
    r=data;
    site=[x;y];



end