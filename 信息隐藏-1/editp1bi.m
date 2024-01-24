function [r]=editp1bi(headr,headc,data,pixel,count,randr,randc)
%pixel：要求修改的色素块的颜色，即要把pixel改为其反
%count：修改数量
        c=0;
        for i =1:64
           %disp([headr,"||||",headc]);
            row=headr+randr(i);
            col=headc+randc(i);
            if data(row,col)==pixel 
                if (data(row-1,col)==~pixel || ...
                    data(row+1,col)==~pixel ||...
                    data(row,col-1)==~pixel ||...
                    data(row,col+1)==~pixel ||...
                    data(row-1,col-1)==~pixel || ...
                    data(row-1,col+1)==~pixel ||...
                    data(row+1,col-1)==~pixel ||...
                    data(row+1,col+1)==~pixel)
                   
                    data(row,col)=~pixel+0.01;
                    c=c+1;
                end
            end
            if c==count
                r=data;
                disp("修改成功");
                return
            end

        end
        if c~=count
            r=data;
            disp("warning，未能按要求修改本块元素，可能出现信息无法提取的情况");
        end
end
