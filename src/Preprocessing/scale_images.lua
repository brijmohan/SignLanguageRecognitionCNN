require 'image'
src = "/home/brij/Documents/IIIT/courses/SMAI/Project/datasets/Triesch/Triesch-Test/original"
dst = "/home/brij/Documents/IIIT/courses/SMAI/Project/datasets/Triesch/Triesch-Test/64x64"
scaleHeight = 64
scaleWidth = 64
labels = dir.getdirectories(src)
for _,letter in ipairs(labels) do
--    print(idx,letter)
    letter_x = letter:sub(-1,-1)
--    imageNames = dir.getfiles(letter..'/uniform')
    imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        img = image.loadPPM(imageName)
        img_scaled = image.scale(img,scaleWidth,scaleHeight)
        imageName_x = imageName:sub(-(imageName:reverse():find('/')-1),-1)
        imageName_x = imageName_x:sub(1, -5) .. '.png'
        image.savePNG(dst..'/'..letter_x..'/'..imageName_x,img_scaled)
    end
end

