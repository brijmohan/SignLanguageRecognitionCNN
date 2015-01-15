-- we assume that the data was loaded into two tables: trainData and testData, which have
-- this form:
-- trainData = {data=Tensor(trsize,3,32,32), labels=Tensor(N)}
-- testData = {data=Tensor(tesize,3,32,32), labels=Tensor(N)}
require 'nn'
require 'image'
--data = torch.load(rgb_dataPath)
dofile('load_images.lua')
yuv_data = samples
yuv_data.size = function(self) return (#self.data)[1] end
-- preprocess trainSet
normalization = nn.SpatialContrastiveNormalization(1, image.gaussian1D(7))
for i = 1,yuv_data:size() do
   -- rgb -> yuv
   local rgb = yuv_data.data[i]
   local yuv = image.rgb2yuv(rgb)
   -- normalize y locally:
   yuv[1] = normalization(yuv[{{1}}])
   yuv_data.data[i] = yuv
end
-- normalize u globally:
mean_u = yuv_data.data[{ {},2,{},{} }]:mean()
std_u = yuv_data.data[{ {},2,{},{} }]:std()
yuv_data.data[{ {},2,{},{} }]:add(-mean_u)
yuv_data.data[{ {},2,{},{} }]:div(-std_u)
-- normalize v globally:
mean_v = yuv_data.data[{ {},3,{},{} }]:mean()
std_v = yuv_data.data[{ {},3,{},{} }]:std()
yuv_data.data[{ {},3,{},{} }]:add(-mean_v)
yuv_data.data[{ {},3,{},{} }]:div(-std_v)

torch.save(datPath,yuv_data)

--[[testData = torch.load("/home/idh/mallikarjun/SignLanguageDetection/data/Test/testData_rgb_32.dat")
testData.size = function() return (#testData.data)[1] end
-- preprocess testSet
for i = 1,testData:size() do
   -- rgb -> yuv
   local rgb = testData.data[i]
   local yuv = image.rgb2yuv(rgb)
   -- normalize y locally:
   yuv[{1}] = normalization(yuv[{{1}}])
   testData.data[i] = yuv
end
-- normalize u globally:
testData.data[{ {},2,{},{} }]:add(-mean_u)
testData.data[{ {},2,{},{} }]:div(-std_u)
-- normalize v globally:
testData.data[{ {},3,{},{} }]:add(-mean_v)
testData.data[{ {},3,{},{} }]:div(-std_v)

torch.save('/home/idh/mallikarjun/SignLanguageDetection/data/Test/testData_yuv_32.dat',testData)
testData = nil--]]
