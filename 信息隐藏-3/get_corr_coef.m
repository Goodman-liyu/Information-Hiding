function [corr_coef]=get_corr_coef(watermark_matrix,watermark_test)
 a=sum((watermark_matrix.*watermark_test),'all');
 b=sqrt(sum((watermark_matrix.*watermark_matrix),'all'))*sqrt(sum((watermark_test.*watermark_test),'all'));
 corr_coef=a/b;
end