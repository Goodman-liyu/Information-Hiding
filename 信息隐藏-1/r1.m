clear 
clc

imgpath="LenaRGB.bmp";
txtpath='information.txt';
goalfile='res.txt';
key=12;

%3.3 
[origin_data,m_data,site]=test3_3_encode(imgpath,txtpath,key);
draw_site(m_data,site);
[r,r_ASCII]=test3_3_decode(m_data,site,goalfile)
analyze_lsb(origin_data,m_data);

%4.3 
dct_change(imgpath);

%4.4
alpha=1;
[origin,modify_data,count]=dct_2_encode(imgpath,txtpath,key,alpha);
subplot(1,2,1),imshow(origin);title("origin");
subplot(1,2,2),imshow(modify_data);title("modified")
[r,resultString]=dct_2_decode(modify_data,key,count);
[res]=jpg(imgpath,txtpath,key);

%5.1
lamda=3;
R0=47;
R1=53;
[res,B]=binaryhide(imgpath,txtpath,key,R0,R1,lamda);
[r,r_string]=b_extract(res,R0,R1,key,lamda,B);
[res2]=jpg_R0(imgpath,txtpath,key,lamda)
[res3]=jpg_lamda(imgpath,txtpath,key,R0,R1,lamda)


