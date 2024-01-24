function stirmark(num,way,seed,ratio,level,alpha,wname,clean_data)
len=length(num);
corr_Wcoef=zeros(len,1);
corr_Dcoef=zeros(len,1);
k=1;

for t=num 
    if way=="JPEG"  %此处用单引号会报错，因为单引号通常用于表示字符数组，而双引号用于表示字符串，尽量都用双引号
        imgpath2 = sprintf('stirmark\\modified_image_JPEG_%d.bmp', t);
        xname="JPEG压缩质量";
    elseif way=="MEDIAN"
        imgpath2 = sprintf('stirmark\\modified_image_MEDIAN_%d.bmp', t);
        xname="MEDIAN中值滤波窗口大小";
    elseif way=="NOISE"
        imgpath2 = sprintf('stirmark\\modified_image_NOISE_%d.bmp', t);
        xname="NOISE噪声比例";
    else
        error('没有这种类型的分析')
    end
    test=imread(imgpath2);
    [corr_coef,DCT_coef]=wavedetect(test,clean_data,seed,ratio,level,alpha,wname);
    corr_Wcoef(k)=corr_coef;
    corr_Dcoef(k)=DCT_coef;
    k=k+1;
end
    
    subplot(211);plot(num,abs(corr_Wcoef),'-o');title("常规检测阈值分析");xlabel(xname);ylabel("相关性值");
    subplot(212);plot(num,abs(corr_Dcoef),'-o');title("DCT变换后检测阈值分析");xlabel(xname);ylabel("相关性值");
end