function [DCT_coef]=get_DCT_coef(watermark_matrix,watermark_test)
    watermark_matrix=dct2(watermark_matrix);
    watermark_test=dct2(watermark_test);

    watermark_matrix(1,1)=0;
    watermark_test(1,1)=0;
    DCT_coef=get_corr_coef(watermark_matrix,watermark_test);
   
end