function psnrValue = calculatePSNR(originalImage, processedImage)
    % 将图像转换为 double 类型
    originalImage = double(originalImage(:,:,1));
    processedImage = double(processedImage(:,:,1));

    % 计算均方误差 MSE
    mse = mean(mean((originalImage - processedImage).^2));

    % 计算 PSNR
    maxValue = max(originalImage(:));
    psnrValue = 10 * log10(maxValue^2 / mse);
end
