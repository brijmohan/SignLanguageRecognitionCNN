----------------------------------------------------------------------
-- This script implements a test procedure, to report accuracy
-- on the test data. Nothing fancy here...
--
-- Clement Farabet
----------------------------------------------------------------------

require 'torch'   -- torch
require 'xlua'    -- xlua provides useful tools, like progress bars
require 'optim'   -- an optimization package, for online and batch methods

----------------------------------------------------------------------
print '==> defining test procedure'


if not opt then
	require 'cutorch'
	require 'nn'
	require 'nnx'
	opt = {}
	testData = torch.load('../../data/Test/testData_yuv_32.dat')
	trainData = torch.load('../../data/Train/trainData_yuv_32.dat')
	-- classes
	classes = {'1','2','3','4','5','6','7','8','9','10'}--,'11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26'}
	-- This matrix records the current confusion across classes
	confusion = optim.ConfusionMatrix(classes)
	opt.type = 'cuda'
	opt.plot = false
	model = torch.load('results/model.net.bak')	
	model:cuda()
end



-- test function
function test()
   -- local vars
   local time = sys.clock()

   -- averaged param use?
   if average then
      cachedparams = parameters:clone()
      parameters:copy(average)
   end
   
   -- set model to evaluate mode (for modules that differ in training and testing, like Dropout)
   --model:evaluate()

   -- test over test data
   print('==> testing on test set:')
   for t = 1,testData:size() do
      -- disp progress
      xlua.progress(t, testData:size())

      -- get new sample
      local input = testData.data[t]
      if opt.type == 'double' then input = input:double()
      elseif opt.type == 'cuda' then 
      	input = input:cuda()
      end
      local target = testData.labels[t]

      -- test sample
      local pred = model:forward(input)
      confusion:add(pred, target)
   end

   -- timing
   time = sys.clock() - time
   time = time / testData:size()
   print("\n==> time to test 1 sample = " .. (time*1000) .. 'ms')

   -- print confusion matrix
   print(confusion)

   -- update log/plot
   testLogger:add{['% mean class accuracy (test set)'] = confusion.totalValid * 100}
   if opt.plot then
      testLogger:style{['% mean class accuracy (test set)'] = '-'}
      testLogger:plot()
   end

   -- averaged param use?
   if average then
      -- restore parameters
      parameters:copy(cachedparams)
   end
   
   -- next iteration:
   confusion:zero()
end
