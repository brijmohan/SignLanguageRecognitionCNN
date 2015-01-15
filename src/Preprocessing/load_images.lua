require 'image'
if not imagesPath then
    imagesPath='/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Test/Images/64x64'
end
local labels = dir.getdirectories(imagesPath)
local nImages = 0 
--print(labels)
for _,letter in ipairs(labels) do
--    print(idx,letter)
    local imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        nImages = nImages + 1 
        if(nImages == 1) then
           tmpimg = image.load(imageName)
        end 
    end 
end

samples = {data = torch.Tensor(nImages,tmpimg:size(1),tmpimg:size(2),tmpimg:size(3)), labels = torch.Tensor(nImages)}
nImages = 0 
for _,letter in ipairs(labels) do
--    print(idx,letter)
        local imageNames = dir.getfiles(letter)
        --print(imageNames)
        for _,imageName in ipairs(imageNames) do
            --print(imageName)
	    nImages = nImages + 1 
            samples.data[nImages] = image.load(imageName)
            samples.labels[nImages] = string.byte(letter:sub(-1,-1)) - string.byte('A',1) + 1 
        end 
end

samples.size = function(self) return (#self.data)[1] end
