function [r]=analyze_lsb(origin_data,m_data)

data1 = origin_data(:);
data2 = m_data(:);
figure;
% 第一个子图
subplot(1, 2, 1);
histogram(data1, 'BinMethod', 'integers');
title('原始图像');
xlabel('数值');
ylabel('出现次数');

% 第二个子图
subplot(1, 2, 2);
histogram(data2, 'BinMethod', 'integers');
title('修改后的图像');
xlabel('数值');
ylabel('出现次数');
end