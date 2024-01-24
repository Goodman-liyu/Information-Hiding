function [res]=jpg_lamda(imgpath,filepath,key,R0,R1,lamda)

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

quality=10:10:100;
lamda=1:10;
result=zeros([max(size(lamda)) max(size(quality))]);
res_r=0;
res_c=0;
j=1;
for l1=lamda

    res_r=res_r+1;
    res_c=0;
    [res,B]=binaryhide(imgpath,filepath,key,R0,R1,l1);
    for q=quality
        different=0;
        res_c=res_c+1;
        imwrite(res,'temp2.jpg','jpg','quality',q);
        tempdata=imread('temp2.jpg');
        [r,r_string]=b_extract(tempdata,R0,R1,key,l1,B);
        for i=1:B
            if r(i)~=A(i)
                different=different+1;
            end
        end
        result(res_r,res_c)=different/B;
    end

    for i=1:10
        plot(quality,result(i,:));       
        hold on;
    end
     legend_str{j} = ['lamda=',num2str(l1)];
     j=j+1;
end
    legend(legend_str);
    xlabel("jpeg压缩质量");
    ylabel("误码率");
end