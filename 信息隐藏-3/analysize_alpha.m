function analysize_alpha(seed,ratio,level,alpha_list,wname,data)

len=length(alpha_list);
corr_Wcoef=zeros(len,1);
corr_Dcoef=zeros(len,1);
k=1;
figure(1);
for alpha=alpha_list
   [watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname);
   imwrite(modified_data,sprintf("alpha\\alpha_%f.bmp", alpha), 'bmp');
   subplot(str2num(sprintf("23%d", k)));imshow(modified_data);title(sprintf("alpha=%f", alpha));
   hold on;
   k=k+1;
end

end