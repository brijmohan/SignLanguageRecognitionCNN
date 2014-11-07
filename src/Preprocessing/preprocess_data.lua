-- we assume that the data was loaded into two tables: trainData and testData, which have
-- this form:
-- trainData = {data=Tensor(trsize,3,32,32), labels=Tensor(N)}
-- testData = {data=Tensor(tesize,3,32,32), labels=Tensor(N)}
require 'nn'
require 'image'
data = torch.load("/home/idh/mallikarjun/SignLanguageDetection/data/Train/trainData_rgb_32.dat")
data.size = function(self) return (#self.data)[1] end
-- preprocess trainSet
normalization = nn.SpatialContrastiveNormalization(1, image.gaussian1D(7))
for i = 1,data:size() do
   -- rgb -> yuv
   local rgb = data.data[i]
   local yuv = image.rgb2yuv(rgb)
   -- normalize y locally:
   yuv[1] = normalization(yuv[{{1}}])
   data.data[i] = yuv
end
-- normalize u globally:
mean_u = data.data[{ {},2,{},{} }]:mean()
std_u = data.data[{ {},2,{},{} }]:std()
data.data[{ {},2,{},{} }]:add(-mean_u)
data.data[{ {},2,{},{} }]:div(-std_u)
-- normalize v globally:
mean_v = data.data[{ {},3,{},{} }]:mean()
std_v = data.data[{ {},3,{},{} }]:std()
data.data[{ {},3,{},{} }]:add(-mean_v)
data.data[{ {},3,{},{} }]:div(-std_v)

torch.save('/home/idh/mallikarjun/SignLanguageDetection/data/Train/trainData_yuv_32.dat',trainData)
data = nil

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
