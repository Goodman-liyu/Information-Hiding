function draw_SC(test,data,seed_range,ratio,level,alpha,wname)

corr_Wcoef=zeros(seed_range,1);
corr_Dcoef=zeros(seed_range,1);
s=1;
for i =1:seed_range
    [corr_coef,DCT_coef]=wavedetect(test,data,i,ratio,level,alpha,wname);
    corr_Wcoef(s)=corr_coef;
    corr_Dcoef(s)=DCT_coef;
    s=s+1;
end
subplot(211);plot(abs(corr_Wcoef));title("常规检测阈值分析");xlabel('种子');ylabel("相关性值");
subplot(212);plot(abs(corr_Dcoef));title("DCT变换后检测阈值分析");xlabel('种子');ylabel("相关性值");

end