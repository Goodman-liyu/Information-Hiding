function [r]=md52num(md5code)
        r=0;
        for i=1:32

            r=r+Table(md5code(i))*i;
        end
        
end