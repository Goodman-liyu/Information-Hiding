function [res]=jpg_R0(imgpath,filepath,key,lamda)

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
R0=36:45;
result=zeros([max(size(R0)) max(size(quality))]);
res_r=0;
res_c=0;
j=1;
for r0=R0
    r1=50+(50-r0);

    res_r=res_r+1;
    res_c=0;
    [res,B]=binaryhide(imgpath,filepath,key,r0,r1,lamda);
    for q=quality
        different=0;
        res_c=res_c+1;
        imwrite(res,'temp2.jpg','jpg','quality',q);
        tempdata=imread('temp2.jpg');
        [r,r_string]=b_extract(tempdata,r0,r1,key,lamda,B);
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
     
     legend_str{j} = strcat('R0=',num2str(r0),";R1=",num2str(r1));
     j=j+1;
end
    legend(legend_str);
    xlabel("jpeg压缩质量");
    ylabel("误码率");
end