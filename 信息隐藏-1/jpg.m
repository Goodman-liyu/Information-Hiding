function [res]=jpg(imgpath,filepath,key)

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
alpha=0.1:0.1:1;
res=zeros([max(size(alpha)) max(size(quality))]);
res_r=0;
res_c=0;
j=1;
for a=alpha

    res_r=res_r+1;
    res_c=0;
   [origin,modify_data,count]=dct_2_encode(imgpath,filepath,key,a);
    for q=quality
        different=0;
        res_c=res_c+1;
        imwrite(modify_data,'temp.jpg','jpg','quality',q);
        tempdata=imread('temp.jpg');
        [r,resultString]=dct_2_decode(tempdata,key,count);
        for i=1:count
            if r(i)~=A(i)
                different=different+1;
            end
        end
        res(res_r,res_c)=different/count;
    end

    for i=1:10
        plot(quality,res(i,:));
        hold on;
    end
     legend_str{j} = ['alpha=',num2str(a)];
     j=j+1;
end
     legend(legend_str);
    xlabel("jpeg压缩质量");
    ylabel("误码率");

end