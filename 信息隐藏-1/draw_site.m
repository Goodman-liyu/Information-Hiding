function [r]=draw_site(m_data,site)

figure;
imshow(m_data);
[a,length]=size(site);
for i=1:length
     x=site(1,i);
     y=site(2,i);
hold on;  
viscircles([x, y], 2, 'EdgeColor', 'r', 'LineWidth', 2); 
end
hold off;  % 停止保持绘图
end