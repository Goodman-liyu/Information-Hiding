function [X,Y]=find_site(D,B)

X=zeros(1,B);
Y=zeros(1,B);
[m,n]=size(D);
count=0;
for i=1:m
    for j=1:n
        if mod(i,8)==1 &&  mod(j,8)==1
            continue;
        elseif D(i,j)~=0 && D(i,j)~=1 &&D(i,j)~=-1
            count=count+1;
            X(count)=i;
            Y(count)=j;
            if count==B
                return;
            end
        end
    end
end

error("无足够的空间来隐藏信息");

end