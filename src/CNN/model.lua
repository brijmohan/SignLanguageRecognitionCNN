model = nn.Sequential()
-- stage 1 : filter bank -> squashing -> max pooling
model:add(nn.SpatialConvolutionMap(nn.tables.random(3,16,1), 5, 5))
model:add(nn.Tanh())
model:add(nn.SpatialLPPooling(16,2,2,2,2,2))
-- stage 2 : filter bank -> squashing -> max pooling
model:add(nn.SpatialSubtractiveNormalization(16, image.gaussian1D(7)))
model:add(nn.SpatialConvolutionMap(nn.tables.random(16, 256, 4), 5, 5))
model:add(nn.Tanh())
model:add(nn.SpatialLPPooling(256,2,2,2,2,2))
-- stage 3 : standard 2-layer neural network
model:add(nn.SpatialSubtractiveNormalization(256, image.gaussian1D(7)))
model:add(nn.Reshape(256*29*29))
model:add(nn.Linear(256*29*29, 128))
model:add(nn.Tanh())
--model:add(nn.Linear(128,#classes))
model:add(nn.Linear(128,26))
model:add(nn.LogSoftMax())
