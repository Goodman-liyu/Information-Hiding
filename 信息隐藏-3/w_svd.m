function [watermark_matrix,watermark_show,origin_data,modified_data,modified_data_R,origin_data_R,realCA]=w_svd(data,seed,ratio,level,alpha,wname)

data=double(data)/255;
origin_data=data;
another=data(:,:,2:3);
data=data(:,:,1);%只在第一个通道上进行处理

origin_data_R=data;
[C, S] = wavedec2(data, level, wname);
origin_C=C;
CA = appcoef2(C, S, wname, level);

%%
%%水印生成
CAmin = min(min(CA));
CAmax = max(max(CA));
realCA=CA;  %返回未归一化的CA
CA = (1/(CAmax - CAmin)) .* (CA - CAmin);   
[U, sigma, V] = svd(CA);

d = max(size(CA));
np=round(d*ratio); %d/n=0.8
rand('seed',seed);
M_V=rand(d,np)-0.5;
[Q_V,~]=qr(M_V,0); %Q_V是一个随机正交阵
M_U=rand(d,np)-0.5;
[Q_U,~]=qr(M_U,0); %Q_U是一个随机正交阵
V(:,d-np+1:d)=Q_V(:,1:np);
U(:,d-np+1:d)=Q_U(:,1:np);
sigma_tilda=alpha*flipud(sort(rand(d,1))); %生成随机对角矩阵，alpha自取
watermark=U*diag(sigma_tilda,0)*V';    %水印生成


%%
% %%水印嵌入
CA_tilda=CA+watermark;
CA_tilda(CA_tilda>1)=1;
CA_tilda(CA_tilda<0)=0; %调整系数
CA_tilda=(CAmax-CAmin)*CA_tilda+CAmin;
watermark_matrix=CA_tilda-realCA;


CA_tilda=reshape(CA_tilda,1, S(1,1)*S(1,2));
C(1,1: S(1,1)* S(1,2))=CA_tilda;
watermarked_image = waverec2(C,S,wname);%图像重构
modified_data_R=watermarked_image;

%还原为3通道显示
modified_data=zeros(512,512,3);
modified_data(:,:,1)=watermarked_image;
modified_data(:,:,2:3)=another;

waterC=origin_C;
waterC(1,1:S(1,1)*S(1,2))=reshape(watermark,1, S(1,1)*S(1,2));
watermark_show= waverec2(waterC,S,wname);%水印重构
end