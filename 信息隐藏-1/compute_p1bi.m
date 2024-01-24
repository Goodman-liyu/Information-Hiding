function [r]=compute_p1bi(headr,headc,image)

    r=0;
    for i=1:10
    for j=1:10
    if image(headr+i-1,headc+j-1)==1
        r=r+1;
    end
    end
    end

end