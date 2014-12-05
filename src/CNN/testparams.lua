require 'image'
require 'nn'
-- 26-class problem
	noutputs = 10

-- input dimensions
	nfeats = 1
	width = 64
	height = 64
	ninputs = nfeats*width*height

-- number of hidden units (for MLP only):
	nhiddens = ninputs / 2

-- hidden units, filter sizes (for ConvNet only):
	nstates = {16,64,256,128}
	fanin = {1,4,4}
	filtsize = 5
	poolsize = 2
	stride = 2
	normkernel = image.gaussian1D(7)

            model = nn.Sequential()
	        
	        -- stage 1 : filter bank -> squashing -> L2 pooling -> normalization
            --model:add(nn.SpatialConvolutionMM(nfeats, nstates[1], filtsize, filtsize))
            model:add(nn.SpatialConvolutionMap(nn.tables.random(nfeats, nstates[1], fanin[1]), filtsize, filtsize))
	        --model:add(nn.Threshold(0,1e-6))
	        model:add(nn.Tanh())
	        --model:add(nn.ReLU())
	        model:add(nn.SpatialMaxPooling(poolsize, poolsize, stride, stride))
	        --model:add(nn.Dropout(0.5))
	        model:add(nn.SpatialSubtractiveNormalization(nstates[1], normkernel))
	        
	        -- stage 2 : filter bank -> squashing -> L2 pooling -> normalization
            --model:add(nn.SpatialConvolutionMM(nstates[1], nstates[2], filtsize, filtsize))
            model:add(nn.SpatialConvolutionMap(nn.tables.random(nstates[1], nstates[2], fanin[2]), filtsize, filtsize))
	        --model:add(nn.Threshold(0,1e-6))
   	        model:add(nn.Tanh())
	        --model:add(nn.ReLU())
	        model:add(nn.SpatialMaxPooling(poolsize, poolsize, stride, stride))
	        --model:add(nn.Dropout(0.5))
        	model:add(nn.SpatialSubtractiveNormalization(nstates[2], normkernel))
        	
        	-- stage 3 : filter bank -> squashing -> L2 pooling -> normalization
            --model:add(nn.SpatialConvolutionMM(nstates[1], nstates[3], filtsize, filtsize))
            model:add(nn.SpatialConvolutionMap(nn.tables.random(nstates[2], nstates[3], fanin[3]), filtsize, filtsize))
	        --model:add(nn.Threshold(0,1e-6))
   	        model:add(nn.Tanh())
	        --model:add(nn.ReLU())
	        model:add(nn.SpatialMaxPooling(poolsize, poolsize, stride, stride))
        	model:add(nn.SpatialSubtractiveNormalization(nstates[3], normkernel))
	        
	        -- stage 4 : standard 2-layer neural network
            --model:add(nn.View(nstates[2]*5*5))
            model:add(nn.View(nstates[3]*4*4))
            --model:add(nn.Dropout(0.5)) -- Adding dropout
	        --model:add(nn.Linear(nstates[2]*5*5, nstates[3]))
	        model:add(nn.Linear(nstates[3]*4*4, nstates[4]))
	        model:add(nn.Tanh())
	        --model:add(nn.ReLU())
	        --model:add(nn.Dropout(0.5))
	        --model:add(nn.Linear(256, 64))
	        --model:add(nn.Threshold(0,1e-6))
   	        --model:add(nn.Tanh())
	        --model:add(nn.ReLU())   
	        --model:add(nn.Dropout(0.5))	        
	        model:add(nn.Linear(nstates[4], noutputs))
