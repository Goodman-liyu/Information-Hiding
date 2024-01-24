function analysize_seed(seed_list,ratio,level,alpha,wname,data)

len=length(seed_list);
corr_Wcoef=zeros(len,1);
corr_Dcoef=zeros(len,1);
k=1;
figure(1);
for seed=seed_list
   [watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname);
   imwrite(modified_data,sprintf("seed\\seed_%d.bmp", seed), 'bmp');
   subplot(str2num(sprintf("33%d", k)));imshow(modified_data);title(sprintf("seed=%d", seed));
   hold on;
   k=k+1;
end

end