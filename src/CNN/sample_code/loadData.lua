require 'image'
require 'mattorch'

-- Parameter Initialization
normImgSize = {xSize = 200, ySize= 200}

-- Data in the format of .mat
data = mattorch.load('')


-- Data in the form of image (jpeg)
img = image.lena()

-- Scale to common resolution
if (img.nDimension() == 3) then
  scale_x = im:size()[2] / xSize;
  scale_y = im:size()[3] / ySize;
  img = image.scale(im, scale_x, scale_y, 'bilinear')
else 
  scale_x = im:size()[1] / xSize;
  scale_y = im:size()[2] / ySize;
  img = image.scale(im, scale_x, scale_y, 'bilinear')
end

-- Normalize the image
-- print '==> preprocessing data: colorspace RGB -> YUV'
-- for i = 1,trainData:size() do
--   img.data[i] = image.rgb2yuv(trainData.data[i])
-- end

-- Add to training data
trainData = {
  data   = img;
  labels = 1;
  size   = 10; 
} 

-- Convert to float for manipulation
  trainData.data = trainData.data:float()

-- Load all the training images
-- Load all the test images





