function analysize_dn(seed,ratio_list,level,alpha,wname,data)

len=length(ratio_list);
corr_Wcoef=zeros(len,1);
corr_Dcoef=zeros(len,1);
k=1;
figure(1);
for ratio=ratio_list
   [watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname);
   imwrite(modified_data,sprintf("ratio\\ratio_%f.bmp", ratio), 'bmp');
   subplot(str2num(sprintf("33%d", k)));imshow(modified_data);title(sprintf("ratio=%f", ratio));
   hold on;
   k=k+1;
end

end