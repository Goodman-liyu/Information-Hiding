clear 
clc

imgpath="penguin.bmp";
txtpath='information2.txt';

goalfile='res.txt';
key=12;
M=[0,1,1,0];
Result=zeros(2,5);
j=1;
number=10;
for i=0.2:0.2:1

% [origin_data,m_data,site]=LSB_encode(imgpath,txtpath,key,i);
% [p]=rs(m_data,M);
% Result(1,j)=p;
% [origin_data,m_data,site]=F5_encode(imgpath,txtpath,i);
% 
% [p]=rs(m_data,M);
% Result(2,j)=p;
% j=j+1;

[origin_data,m_data,site]=LSB_encode(imgpath,txtpath,key,i);
[divide_data]=divide(m_data,number);  %分块
[divide_p]=get_lsb_P_divide(divide_data,number);
Result(1,j)=mean(divide_p);

[origin_data,m_data,site]=F5_encode(imgpath,txtpath,i);

[divide_data]=divide(m_data,number);  %分块
[divide_p]=get_lsb_P_divide(divide_data,number);
Result(2,j)=mean(divide_p);
j=j+1;



end

plot(0.1:0.1:0.5,Result(1,:),'r-*','Linewidth', 1, 'MarkerSize', 3);
hold on
plot(0.1:0.1:0.5,Result(2,:),'b-*','Linewidth', 1, 'MarkerSize', 3);
legend('LSB隐写图像','F5隐写图像');
xlabel("信息嵌入率");
ylabel("图像隐写率");
title("不同嵌入率下的卡方隐写分析");







