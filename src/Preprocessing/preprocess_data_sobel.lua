-- we assume that the data was loaded into two tables: trainData and testData, which have
-- this form:
-- trainData = {data=Tensor(trsize,3,32,32), labels=Tensor(N)}
-- testData = {data=Tensor(tesize,3,32,32), labels=Tensor(N)}
require 'nn'
require 'image'
--data = torch.load(rgb_dataPath)
yuv_data = samples
yuv_data.size = function(self) return (#self.data)[1] end
-- preprocess trainSet
normalization = nn.SpatialContrastiveNormalization(1, image.gaussian1D(7))

-- Local Normalization of all 3-layers
--[[
for i = 1,yuv_data:size() do
   local featImg = yuv_data.data[i]
   local normalizedImg = torch.Tensor(3, 128, 128)
   -- normalize channels locally:
   normalizedImg[1] = normalization(featImg[{{1}}])
   normalizedImg[2] = normalization(featImg[{{2}}])
   normalizedImg[3] = normalization(featImg[{{3}}])
   yuv_data.data[i] = normalizedImg
end
--]]

-- Local normalization of 1st layer, Global Normalization of last 2-layers
for i = 1,yuv_data:size() do
   local featImg = yuv_data.data[i]
   -- normalize channels locally:
   featImg[1] = normalization(featImg[{{1}}])
   yuv_data.data[i] = featImg
end
-- normalize sobelX globally:
mean_u = yuv_data.data[{ {},2,{},{} }]:mean()
std_u = yuv_data.data[{ {},2,{},{} }]:std()
yuv_data.data[{ {},2,{},{} }]:add(-mean_u)
yuv_data.data[{ {},2,{},{} }]:div(-std_u)
-- normalize sobelY globally:
mean_v = yuv_data.data[{ {},3,{},{} }]:mean()
std_v = yuv_data.data[{ {},3,{},{} }]:std()
yuv_data.data[{ {},3,{},{} }]:add(-mean_v)
yuv_data.data[{ {},3,{},{} }]:div(-std_v)

print('Saved file to ' .. dataPath)
torch.save(dataPath,yuv_data)

