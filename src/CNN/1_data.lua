require 'torch'   -- torch
require 'image'   -- for color transforms
--require 'gfx.js'  -- to visualize the dataset
--require 'nn'      -- provides a normalization operator
--require 'mattorch'

----------------------------------------------------------------------
-- parse command line arguments
if not opt then
   print '==> processing options'
   cmd = torch.CmdLine()
   cmd:text()
   cmd:text('SVHN Dataset Preprocessing')
   cmd:text()
   cmd:text('Options:')
   cmd:option('-size', 'small', 'how many samples do we load: small | full | extra')
   cmd:option('-visualize', true, 'visualize input data and weights during training')
   cmd:text()
   opt = cmd:parse(arg or {})
end

print '==> loading dataset'
trainData = torch.load("../../data/ex3/trainData_128_rgb.dat")
testData = torch.load("../../data/ex3/testData_128_rgb.dat")
----------------------------------------------------------------------
-- training/test size

trsize = (#trainData.data)[1]
tesize = (#testData.data)[1]

