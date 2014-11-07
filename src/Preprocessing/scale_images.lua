require 'image'
src = "/home/idh/mallikarjun/SignLanguageDetection/data/Train/Images/128x128"
dst = "/home/idh/mallikarjun/SignLanguageDetection/data/Train/Images/32x32"
scaleHeight = 32
scaleWidth = 32
labels = dir.getdirectories(src)
for _,letter in ipairs(labels) do
--    print(idx,letter)
    letter_x = letter:sub(-1,-1)
    imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        img = image.load(imageName)
	img_scaled = image.scale(img,scaleWidth,scaleHeight)
	imageName_x = imageName:sub(-(imageName:reverse():find('/')-1),-1)
        image.savePNG(dst..'/'..letter_x..'/'..imageName_x,img_scaled)
    end
end

