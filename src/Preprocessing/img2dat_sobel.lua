require 'image'
print('Note: **run this program from its folder**')
rootPath='/home/brij/Documents/IIIT/courses/SMAI/Project/datasets/Triesch/Triesch-Test/128x128_sobel'
originalPath='/home/brij/Documents/IIIT/courses/SMAI/Project/datasets/Triesch/Triesch-Test/original'
dataPath='../../data/Test/testData_triesch_128_sobel.dat'
--yuv_dataPath = '../../data/Test/testData_triesch_64.dat'
labels = dir.getdirectories(originalPath)
nImages = 0
X = {}
y = {}
--print(labels)
for _,letter in ipairs(labels) do
--    print(idx,letter)
    imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        nImages = nImages + 1
        
        featureImg = torch.Tensor(3, 128, 128)
        
        --Getting image name
        temp = string.split(imageName,'/')
        imageNameWithExt = temp[#temp]
        imageNamex = imageNameWithExt:sub(1,-5)
        
        featureImg[1] = image.loadPPM(rootPath .. '/' .. letter:sub(-1,-1) .. '/' .. imageNameWithExt)
        featureImg[2] = image.loadPNG(rootPath .. '/' .. letter:sub(-1,-1) .. '/' .. imageNamex .. '_sobelX.png')
        featureImg[3] = image.loadPNG(rootPath .. '/' .. letter:sub(-1,-1) .. '/' .. imageNamex .. '_sobelY.png')
        
        X[nImages] = featureImg
        y[nImages] = string.byte(letter:sub(-1,-1)) - string.byte('A',1) + 1
    end
end
samples = {data=torch.zeros(nImages,(#X[1])[1],(#X[1])[2],(#X[1])[3]),labels=torch.zeros(nImages)}
for i=1,nImages do
    samples.data[i]=X[i]
    samples.labels[i] = y[i]
end
samples.size = function(self) return (#self.data)[1] end
--torch.save(dataPath,samples)
print('starting preprocessing..')
dofile('preprocess_data_sobel.lua')
print('preprocessing completed')
