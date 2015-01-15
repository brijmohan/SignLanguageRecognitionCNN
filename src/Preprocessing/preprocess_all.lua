augmentation = false 
scaling = true 
clrtransform = true

if augmentation then
    print('Started data augmentation...')
    imagesPath = "/data1/sign_language_recognition/data/processed/128_yuv_augmented/train/images_temp"
    dofile('images_extras.lua')
    print('Data augmentation completed')
end

if scaling then
    print('started scaling images...')
    src = "/data1/sign_language_recognition/data/processed/128_yuv_augmented/train/images_temp" 
    dst = "/data1/sign_language_recognition/data/processed/128_yuv_augmented/train/images" 
    scaleHeight = 128 
    scaleWidth = 128    
    dofile('scale_images.lua')
    print('Scaling images completed')
end

if clrtransform then
    print('started color transformation')
    clrtransform_type = 'rgb2yuv'
    imagesPath = "/data1/sign_language_recognition/data/processed/128_yuv_augmented/train/images" 
    datPath = "/data1/sign_language_recognition/data/processed/128_yuv_augmented/train/128_yuv_augmented.dat"
    preprocess_type = 'rgb2yuv'
    if(preprocess_type == 'rgb2yuv') then
        dofile('rgb_yuv.lua')
    elseif(preprocess_type == 'rgb2nrgb') then
        dofile('rgb_normalize.lua') 
    end
    print('color transformation completed') 
else
    print('saving images to dat file...')
    imagesPath='/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Test/Images/64x64'
    datPath = "../../data/Test/testData_64.dat"
    dofile('img2dat.lua')
    print('save completed')
end

