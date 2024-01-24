function darw_3d(test,watermark_matrix,level, wname)

test=double(test(:,:,1))/255;
[C, S] = wavedec2(test, level, wname);
CA = appcoef2(C, S, wname, level);
difference=watermark_matrix-CA;
% 获取差异矩阵的维度
[m, n] = size(difference);
[x, y] = meshgrid(1:n, 1:m);
figure;
surf(x, y, difference);
title('Watermark CA Difference');
zlim([-0.2, 0.2]);
xlabel('Column');
ylabel('Row');
zlabel('Difference');

end