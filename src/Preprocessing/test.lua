--[[cmd = torch.CmdLine()
cmd:text()
cmd:text()
cmd:text('Training a simple network')
cmd:text()
cmd:text('Options')
cmd:option('-seed',123,'initial random seed')
cmd:option('-booloption',false,'boolean option')
cmd:option('-stroption','mystring','string option')
cmd:text()
-- parse input params
params = cmd:parse(arg)
params.rundir = cmd:string('experiment', params, {dir=true})
-- create log file
cmd:log(params.rundir .. '/log', params)
--]]
--[[require 'image'
rootPath = '/home/idh/mallikarjun/SignLanguageDetection/data/Train/Images/'
labels_128 = dir.getdirectories('/home/idh/mallikarjun/SignLanguageDetection/data/Train/Images/128x128')
--letters_orig = dir.getdirectories('/home/idh/mallikarjun/SignLanguageDetection/data/Train/Images/original')
for _,label in ipairs(labels_128) do
    letter = string.split(label,'/')
    letter = letter[#letter]
    orig_fc = dir.getfiles(rootPath..'original/'..letter)
    extras_fc = dir.getfiles(label)
--    print(letter)
--    print('original: '..#orig_fc)
--    print('extras: '..#extras_fc)
--   print('expected: '..tostring(32 * #orig_fc))
    if(#extras_fc ~= 32 * #orig_fc) then 
	print(letter)
    end
end--]]

require 'cutorch'
torch.setdefaulttensortype('torch.CudaTensor')
print(  cutorch.getDeviceProperties(cutorch.getDevice()) )
