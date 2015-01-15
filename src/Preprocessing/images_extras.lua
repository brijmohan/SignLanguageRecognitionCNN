require 'image'
if not imagesPath then
    imagesPath = "../../data/Train/Images/64x64_aug/"
end

local labels = dir.getdirectories(imagesPath)

for _,letter in ipairs(labels) do
--    print(idx,letter)
    local imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        local img = image.load(imageName)
        local image_sz = img:size(3)
        local trans_sz = torch.floor(image_sz*0.1)
        local rot =  10*(math.pi/180)
        local img_hflip = image.hflip(img)
        local img_extras = {}
        --os.execute('rm '..imageName)
        img_extras[1] = image.translate(img,trans_sz,trans_sz)
        img_extras[2] = image.translate(img_hflip,trans_sz,trans_sz)
        img_extras[3] = image.rotate(img,rot)
        img_extras[4] = image.rotate(img_hflip,rot)
        img_extras[5] = image.rotate(img,-rot)
        img_extras[6] = image.rotate(img_hflip,-rot)
	
        --[[gauss_noise = image.gaussian(image_sz)
        img_extras[7] = torch.Tensor(img:size())
        img_extras[8] = torch.Tensor(img:size())
        for i = 1,3 do
            img_extras[7][i] = img[i] + gauss_noise
            img_extras[8][i] = img_hflip[i] + gauss_noise
        end]]--
    
        local temp = string.split(imageName,'/')
        local imageNamex = temp[#temp]:sub(1,-5)
        local images = {}
        local stride = math.floor(image_sz*0.1)
        for i,imgx in ipairs(img_extras) do
            images[1] = image.crop(imgx,1,1,image_sz-stride,image_sz-stride)
            images[2] = image.crop(imgx,1+stride,1,image_sz,image_sz-stride)
            images[3] = image.crop(imgx,1,1+stride,image_sz-stride,image_sz)
                images[4] = image.crop(imgx,1+stride,1+stride,image_sz,image_sz)
            for j = 1,4 do
                image.savePNG(letter..'/'..imageNamex..'_'..tostring(4*(i-1)+j)..'.png',images[j])
            end
        end
    end
end


