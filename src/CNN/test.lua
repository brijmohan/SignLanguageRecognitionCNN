require 'cutorch'
require 'cunn'

function maxidx(input)
    max_val = input[1]
    max_idx = 1
    for i = 2,input:size(1) do
        if max_val < input[i] then
            max_val = input[i]
            max_idx = i
        end
    end
    return max_idx
end

dtrain = torch.load('../../data/Test/testData_yuv_32.dat')
model = torch.load('results/model.net.bak')
matches = 0
nSamples = dtrain.data:size(1)
for i = 1,nSamples do
    local input = (dtrain.data[i]):cuda()
    local pred = model:forward(input)
    predidx = maxidx(pred:float())
    if(predidx == dtrain.labels[i]) then
        matches = matches + 1
--        print(matches)
    end
end
print('accuracy: '..tostring(matches/nSamples))
