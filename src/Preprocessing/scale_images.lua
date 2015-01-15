require 'image'
if not src and not dst then
    src = "/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Test/Images/128x128"
    dst = "/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Test/Images/64x64"
elseif (not src and dst) or (src and not dst) then
    print('Both src and dst paths must be defined')
    exit()
end

if not scaleHeight and not scaleWidth then
    scaleHeight = 64
    scaleWidth = 64
elseif (not scaleHeight and scaleWidth) or (scaleHeight and not scaleWidth) then
    print('Both scaleHeight and scaleWidth must be defined')
    exit()
end
os.execute('mkdir '..dst)
for i=0,25 do
    os.execute('mkdir '..dst..'/'..string.char(string.byte('A')+i))
end
local labels = dir.getdirectories(src)
for _,letter in ipairs(labels) do
--    print(idx,letter)
    local letter_x = letter:sub(-1,-1)
--    imageNames = dir.getfiles(letter..'/uniform')
    local imageNames = dir.getfiles(letter)
--    print(imageNames)
    for _,imageName in ipairs(imageNames) do
        local img = image.load(imageName)
        local img_scaled = image.scale(img,scaleWidth,scaleHeight)
        local imageName_x = imageName:sub(-(imageName:reverse():find('/')-1),-1)
        imageName_x = imageName_x:sub(1, -5) .. '.png'
        image.savePNG(dst..'/'..letter_x..'/'..imageName_x,img_scaled)
    end
end

