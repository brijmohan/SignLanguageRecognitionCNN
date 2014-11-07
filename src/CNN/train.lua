criterion = nn.ClassNLLCriterion()
criterion = optim.ConfusionMatrix()

-- retrieve parameters and gradients
parameters,gradParameters = model:getParameters()
 
-- training function:
function train(dataset)
   -- epoch tracker
   epoch = epoch or 1
 
   -- local vars
   local time = sys.clock()
 
   -- shuffle at each epoch
   shuffle = torch.randperm(trsize)
 
   -- do one epoch
   print('<trainer> on training set:')
   print("<trainer> online epoch # " .. epoch .. ' [batchSize = ' .. opt.batchSize .. ']')
   for t = 1,dataset:size(),opt.batchSize do
      -- disp progress
      xlua.progress(t, dataset:size())
 
      -- create mini batch
      local inputs = {}
      local targets = {}
      for i = t,math.min(t+opt.batchSize-1,dataset:size()) do
         -- load new sample
         local input = dataset.data[shuffle[i]]:double()
         local target = dataset.labels[shuffle[i]]
         table.insert(inputs, input)
         table.insert(targets, target)
      end
 
      -- create closure to evaluate f(X) and df/dX
      local feval = function(x)
                       -- get new parameters
                       if x ~= parameters then
                          parameters:copy(x)
                       end
 
                       -- reset gradients
                       gradParameters:zero()
 
                       -- f is the average of all criterions
                       local f = 0
 
                       -- evaluate function for complete mini batch
                       for i = 1,#inputs do
                          -- estimate f
                          local output = model:forward(inputs[i])
                          local err = criterion:forward(output, targets[i])
                          f = f + err
 
                          -- estimate df/dW
                          local df_do = criterion:backward(output, targets[i])
                          model:backward(inputs[i], df_do)
 
                          -- update confusion
                          confusion:add(output, targets[i])
                       end
 
                       -- normalize gradients and f(X)
                       gradParameters:div(#inputs)
                       f = f/#inputs
 
                       -- return f and df/dX
                       return f,gradParameters
                    end
 
      -- optimize on current mini-batch
      if opt.optimization == 'CG' then
         config = config or {maxIter = opt.maxIter}
         optim.cg(feval, parameters, config)
 
      elseif opt.optimization == 'LBFGS' then
         config = config or {learningRate = opt.learningRate,
                             maxIter = opt.maxIter,
                             nCorrection = 10}
         optim.lbfgs(feval, parameters, config)
 
      elseif opt.optimization == 'SGD' then
         config = config or {learningRate = opt.learningRate,
                             weightDecay = opt.weightDecay,
                             momentum = opt.momentum,
                             learningRateDecay = 5e-7}
         optim.sgd(feval, parameters, config)
 
      elseif opt.optimization == 'ASGD' then
         config = config or {eta0 = opt.learningRate,
                             t0 = trsize * opt.t0}
         _,_,average = optim.asgd(feval, parameters, config)
 
      else
         error('unknown optimization method')
      end
   end
 
   -- time taken
   time = sys.clock() - time
   time = time / dataset:size()
   print("<trainer> time to learn 1 sample = " .. (time*1000) .. 'ms')
 
   -- print confusion matrix
   print(confusion)
   confusion:zero()
 
   -- next epoch
   epoch = epoch + 1
end
