function K2(input)
ste_cover = rgb2gray(imread(input));
[~, n] = size(ste_cover);
P_values = zeros(1, 10); % 存储P值的数组
percentages = 10:10:100; % 存储每次处理的像素范围的百分比
for i = 1:10:100
    range = i:min(i + n/10 - 1, n); % 计算当前处理的像素范围
    ste_cover_partial = ste_cover(:, range);
    count = imhist(ste_cover_partial);
    X = 0;
    k = 0;
    % 计算卡方统计值
    for j = 1:128
        if (count(2*j - 1) + count(2*j)) ~= 0
            X = X + (count(2*j - 1) - count(2*j))^2 / (2 * (count(2*j - 1) + count(2*j)));
            k = k + 1;
        end
    end
    P = 1 - chi2cdf(X, k);
    P_values((i + 9) / 10) = P;
end
% 绘制P值图像
plot(percentages, P_values);
xlabel('像素范围百分比');
ylabel('P值');
title('P值随像素范围的变化');
if max(P_values) > 0.85
    disp('图像中含有秘密信息');
else
    disp('图像中没有秘密信息');
end
end