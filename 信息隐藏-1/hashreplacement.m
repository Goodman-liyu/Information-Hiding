function [row,col]=hashreplacement(matrix,count,k1,k2,k3)

    [X,Y]=size(matrix);
    row=zeros([1,count]);
    col=zeros([1,count]);
    j=zeros([1,count]);
    for i=1:count

        v=round(i/X);
        u=mod(i,X);
        v=mod(v+md52num(GetMD5(num2str(u+k1))),Y);  %注意m是个数值，需要改为str
        u=mod(u+md52num(GetMD5(num2str(v+k2))),X);
        v=mod(v+md52num(GetMD5(num2str(u+k3))),Y);
        j(i)=v*X+u+1;
        col(i)=mod(j(i),Y);
        row(i)=floor(j(i)/Y)+1;
      
        %row(i)=double(uint8(row(i)))+1;
        if col(i)==0
            col(i)=Y;
            row(i)=row(i)-1;
         
        end
    end
end