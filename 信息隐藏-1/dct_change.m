function [r]=dct_change(imgpath)
f=rgb2gray(imread(imgpath));
f=double(f)/255;
T=dctmtx(8);
B=blkproc(f,[8 8],'P1*x*P2',T,T');
X=[1 1 1 1 0 0 0 0
1 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0];
B2=blkproc(B,[8 8],'P1.*x',X);
% subplot(1,2,1),imshow(log(abs(B)),[]);title('原始图像');
% colormap parula
% colorbar
% subplot(1,2,2),imshow(log(abs(B2)),[]);title('修改后的图像');
% colormap parula
% colorbar
I2=blkproc(B2,[8 8],'P1*x*P2',T',T);
subplot(1,3,1),imshow(f);title('原始图像');
subplot(1,3,2),imshow(I2);title('逆变换后的图像');
M=I2-f;
subplot(1,3,3),imshow(mat2gray(M)),title('图像细节');

end