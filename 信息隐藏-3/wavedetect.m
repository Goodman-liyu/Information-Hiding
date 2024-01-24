function [corr_coef,DCT_coef]=wavedetect(test,sample,seed,ratio,level,alpha,wname)
%test是要检测图像的矩阵，RGB3维
%sample是原始图像的矩阵
test=double(test)/255;
test=test(:,:,1);
[watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(sample,seed,ratio,level,alpha,wname);
%后续需要用到此处的watermark_matrix---真实水印矩阵
[C, S] = wavedec2(test, level, wname);
CA_test = appcoef2(C, S, wname, level);
watermark_test=CA_test-realCA;
corr_coef=get_corr_coef(watermark_matrix,watermark_test);
DCT_coef=get_DCT_coef(watermark_matrix,watermark_test);
end