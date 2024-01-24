function analysize_wname(seed,ratio,level,alpha,wname_list,data)

len=length(wname_list);
corr_Wcoef=zeros(len,1);
corr_Dcoef=zeros(len,1);
k=1;
figure(1);
for wname=wname_list
   [watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname);
   imwrite(modified_data,sprintf("wname\\wname_%s.bmp", wname), 'bmp');
   subplot(str2num(sprintf("22%d", k)));imshow(watermark_show);title(sprintf("wname=%s", wname));
   hold on;
   k=k+1;
end

end