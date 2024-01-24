function [origin,modify_data,count]=dct_2_encode(imgpath,filepath,key,alpha)
    
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
     
   
    data=imread(imgpath);
    data=double(data)/255;  %像素值转换为double类型，并缩放到0-1的范围
    origin=data;
    data_R=data(:,:,1);
  
    T=dctmtx(8);
    dctrgb=blkproc(data_R,[8 8],'P1*x*P2',T,T');
    
    [row,col]=size(dctrgb);
    row=floor(row/8);
    col=floor(col/8);
    a=zeros([row col]);

    [k1,k2]=randinterval(a,B,key);
    for i=1:B
        k1(i)=(k1(i)-1)*8+1;
        k2(i)=(k2(i)-1)*8+1;    
    end
    
    temp=0;
    for i=1:B
        if A(i)==0
            if dctrgb(k1(i)+4,k2(i)+1)>dctrgb(k1(i)+3,k2(i)+2)
                temp= dctrgb(k1(i)+4,k2(i)+1);
                dctrgb(k1(i)+4,k2(i)+1)=dctrgb(k1(i)+3,k2(i)+2);
                dctrgb(k1(i)+3,k2(i)+2)=temp;
            end
        else 
            if dctrgb(k1(i)+4,k2(i)+1)<dctrgb(k1(i)+3,k2(i)+2)
                temp= dctrgb(k1(i)+4,k2(i)+1);
                dctrgb(k1(i)+4,k2(i)+1)=dctrgb(k1(i)+3,k2(i)+2);
                dctrgb(k1(i)+3,k2(i)+2)=temp;
            end

        end
          %将原本小的系数放的更小，增大差异
    if dctrgb(k1(i)+4,k2(i)+1)>dctrgb(k1(i)+3,k2(i)+2)
               dctrgb(k1(i)+3,k2(i)+2)=dctrgb(k1(i)+3,k2(i)+2)-alpha;
    else
        dctrgb(k1(i)+4,k2(i)+1)=dctrgb(k1(i)+4,k2(i)+1)-alpha;
    end
    end
    
  

   modify_data=origin;
   modify_data(:,:,1)=blkproc(dctrgb,[8 8],'P1*x*P2',T',T);

   count=B;

end
