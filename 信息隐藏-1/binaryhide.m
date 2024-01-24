function [res,count]=binaryhide(imgpath,filepath,key,R0,R1,lamda)

    fid=fopen(filepath,'r');
    [A,B]=fread(fid,'ubit1');
    fclose(fid);
    tA=A;
    count=B;
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
    data=im2bw(data,0.5);
    data=double(data);
    origin=data;
        
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


    temp=zeros(8);
    [randr,randc]=hashreplacement(temp,64,key,m,n);

    [availabler,availablec,image]=available(A,B,row,col,m,n,data,R1,R0,lamda,randr,randc);

    for i=1:B
        p1bi=compute_p1bi(availabler(i),availablec(i),image);
        if A(i)==1
            if p1bi<R1
                image=editp1bi(availabler(i),availablec(i),image,0,R1-p1bi+1,randr,randc);
            elseif p1bi>R1+lamda
                    image=editp1bi(availabler(i),availablec(i),image,1,p1bi-R1-lamda+1,randr,randc);
            else
            end
        end

        if A(i)==0
            if p1bi>R0
                image=editp1bi(availabler(i),availablec(i),image,1,p1bi+1-R0,randr,randc);
            elseif p1bi<R0-lamda
                image=editp1bi(availabler(i),availablec(i),image,0,R0-lamda-p1bi+1,randr,randc);
            else
            end
        end 
    end
    
    image=round(image);
    res=image;
   % subplot(1,2,1),imshow(origin),title('原始图像');
    %subplot(1,2,2),imshow(res),title('修改后的图像');

end