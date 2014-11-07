require 'image'
rootPath ='/home/idh/mallikarjun/SignLanguageDetection/data/Train/Images/32x32' 
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
saveto='/home/idh/mallikarjun/SignLanguageDetection/data/Train/trainData_rgb_32.dat'
torch.save(saveto,samples)
