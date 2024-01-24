function analysize_level(seed,ratio,level_list,alpha,wname,data)

len=length(level_list);
corr_Wcoef=zeros(len,1);
corr_Dcoef=zeros(len,1);
k=1;
figure(1);
for level=level_list
   [watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname);
   imwrite(modified_data,sprintf("level\\level_%d.bmp", level), 'bmp');
   subplot(str2num(sprintf("23%d", k)));imshow(watermark_show);title(sprintf("level=%d", level));
   hold on;
   k=k+1;
end

end