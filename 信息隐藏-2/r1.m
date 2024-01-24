clear 
clc

imgpath="penguin.bmp";
imgpath="333.png"
 data=rgb2gray(imread(imgpath));
 imshow(data)
txtpath='information2.txt';
%txtpath='information2.txt';  %JSTEG,F3,F4,F5用此数据

goalfile='res.txt';
key=12;

M=[0,1,1,0];
number=10;  

%针对LSB的卡方分析
[origin_data,m_data,site]=LSB_encode(imgpath,txtpath,key,1);

[count] =get_count(m_data);  %整块
[p]=get_lsb_P(count);

[divide_data]=divide(m_data,number);  %分块
[divide_p]=get_lsb_P_divide(divide_data,number);
plot(1:number,divide_p,'r-*','Linewidth', 1, 'MarkerSize', 3);
xlabel("块序号");
ylim(0:1);
ylabel("P值");
title("分块卡方分析");

[r,r_ASCII]=LSB_decode(m_data,site,goalfile);


%LSBM
[origin_data,m_data,site]=LSBM_encode(imgpath,txtpath,key,1);
[r,r_ASCII]=LSB_decode(m_data,site,goalfile);


%RS
[p]=rs(m_data,M);


%Jsteg
[origin_data,m_data,site]=Jsteg_encode(imgpath,txtpath);
Jsteg_origin(origin_data);
Jsteg_modified(m_data);
[r,r_ASCII]=Jsteg_decode(m_data,site,goalfile);

%F4
[origin_data,m_data,site]=F4_encode(imgpath,txtpath,1);
[r,r_ASCII]=F4_decode(m_data,site,goalfile);

%F5
[origin_data,m_data,length]=F5_encode(imgpath,txtpath,1);
[r,r_ASCII]=F5_decode(m_data,length);

 subplot(1,2,1),imshow(origin_data);title("origin");
    subplot(1,2,2),imshow(m_data);title("modified(F5)");

