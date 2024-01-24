clear 
clc

imgpath="penguin.bmp";
%imgpath="LenaRGB.bmp";
%testpath="modified_image.bmp";
level=4;
wname="haar";
seed=5;
alpha=0.9;
ratio=0.9;
data=imread(imgpath);

[watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname);
figure(1);
subplot(231);imshow(origin_data);title("原始图像");
subplot(232);imshow(modified_data);title("嵌入水印后的图像");
subplot(233);imshow(watermark_show);title("水印形态图");
subplot(234);imshow(origin_data_R);title("R通道原始图像");
subplot(235);imshow(modified_data_R);title("R通道嵌入水印后的图像");
imwrite(modified_data,"modified_image.bmp", 'bmp');

CA_compare=watermark_matrix+realCA;
test=imread(testpath);
darw_3d(test,CA_compare,level, wname);

%%
test=imread(testpath);
[corr_coef,DCT_coef]=wavedetect(test,data,seed,ratio,level,alpha,wname)



%%
%SC
seed_range=20;
draw_SC(test,data,seed_range,ratio,level,alpha,wname);


%%
%stirmark

num=[0:10:100];%JEPG
way="JPEG";

% % 
% num=[3,5,7,9];%MEDIAN
% way="MEDIAN";


% num=[0:10:100];%NOISE
% way="NOISE";

stirmark(num,way,seed,ratio,level,alpha,wname,data);


%%

alpha_list=[0.1,0.3,0.5,0.7,0.9,1];
ratio_list=[0.1:0.1:0.9];
wname_list=["db3","db6","db9","haar"];
level_list=[1:6];
seed_list=[1:9];

analysize_alpha(seed,ratio,level,alpha_list,wname,data);
analysize_dn(seed,ratio_list,level,alpha,wname,data);
analysize_wname(seed,ratio,level,alpha,wname_list,data);
analysize_level(seed,ratio,level_list,alpha,wname,data);
analysize_seed(seed_list,ratio,level,alpha,wname,data);

%%
%%psnr
psnr=zeros(1,9);
imgpath="penguin.bmp";
data=imread(imgpath);
for i=1:9
testpath=sprintf("seed\\seed_%d.bmp",i);
test=imread(testpath);
psnrValue = calculatePSNR(data, test);
psnr(i)=psnrValue;
end

plot(psnr,'-o');title("不同随机种子下的PSNR检测");xlabel("随机种子值");ylabel("PSNR");ylim([20,30]);









