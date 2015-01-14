require 'image'
rootPath = "../../data/Train/Images/64x64_aug/"
labels = dir.getdirectories(rootPath)

for _,letter in ipairs(labels) do
--    print(idx,letter)
    imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        img = image.load(imageName)
        image_sz = img:size(3)
	trans_sz = torch.floor(image_sz*0.1)
	rot =  10*(math.pi/180)
	img_hflip = image.hflip(img)
	img_extras = {}
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
    
    temp = string.split(imageName,'/')
	imageNamex = temp[#temp]:sub(1,-5)
	images = {}
	stride = math.floor(image_sz*0.1)
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

