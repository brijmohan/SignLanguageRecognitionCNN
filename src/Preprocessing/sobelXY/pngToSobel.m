function [sobelX, sobelY] = pngToSobel(img)
    
    if size(img, 3) == 1
        imgGray = img;
    else
        imgGray = rgb2gray(img);
    end
    [sobelX, sobelY] = imgradientxy(imgGray,'sobel');

end