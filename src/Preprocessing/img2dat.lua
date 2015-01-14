require 'image'
print('Note: **run this program from its folder**')
rootPath='/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Test/Images/64x64'
--dataPath='../../data/Train/trainData_64_aug.dat'
yuv_dataPath = '../../data/Test/testData_64.dat'
labels = dir.getdirectories(rootPath)
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
        X[nImages] = image.load(imageName)
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
dofile('preprocess_data.lua')
print('preprocessing completed')
