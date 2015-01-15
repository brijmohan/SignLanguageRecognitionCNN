require 'image'
print('Note: **run this program from its folder**')
if not rootPath then
    imagesPath='/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Test/Images/64x64'
end
if not datPath then
    datPath='../../data/Train/trainData_64_aug.dat' -- dataPath for raw images .dat file
end    
dofile('load_images')
torch.save(datPath,samples)

