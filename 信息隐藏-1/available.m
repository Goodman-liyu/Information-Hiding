function [availabler,availablec,image]=available(msg,count,row,col,m,n,data,R1,R0,lamda,randr,randc)

    msgquan=1; %代表即将嵌入的信息索引
    unable=0;
    difficult=0;

    for blockquan=1:m*n

        p1bi=compute_p1bi(row(blockquan),col(blockquan),data);  %计算一个10*10块中值为1的像素点
        if p1bi>=R1+3*lamda || p1bi<=R0-3*lamda
            row(blockquan)=-1;
            col(blockquan)=-1;
            unable=unable+1;
            msgquan=msgquan-1;
        elseif msg(msgquan)==1 && p1bi<=R0
            data=editp1bi(row(blockquan),col(blockquan),data,1,3*lamda,randr,randc);
            row(blockquan)=-1;
            col(blockquan)=-1;
            difficult=difficult+1;
            msgquan=msgquan-1;


        elseif msg(msgquan)==0 && p1bi>=R1  
            data=editp1bi(row(blockquan),col(blockquan),data,0,3*lamda,randr,randc);
            row(blockquan)=-1;
            col(blockquan)=-1;
            difficult=difficult+1;
            msgquan=msgquan-1;
        else
        end

        msgquan=msgquan+1;
        if msgquan==count+1
            for i=(blockquan+1):m*n
            row(i)=-1; %made  此处写成了row(blockquan)
            col(i)=-1;
            end
            break;
  
        end
    end

    if msgquan<=count
        error("载体过小");
    end

    quan=max(size(row(row~=-1)));
    if quan<count
        error("载体过小");
    end

    data=round(data);
    availabler=zeros([1,quan]);
    availablec=zeros([1,quan]);
    j=1;
    for i=1:m*n
        if row(i)~=-1
            availabler(j)=row(i);
            availablec(j)=col(i);
            j=j+1;
        end 
    end

    image=data;
end