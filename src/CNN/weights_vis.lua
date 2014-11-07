function normalizeImages(images3d, imagesPerRow)
	
	for i = 1,images3d:size(1) do
	
		local min = images3d[i]:min()
		local max = images3d[i]:max()
		-- rescale image:
		images3d[i] = torch.FloatTensor(images3d[i]:size()):copy(images3d[i])
		images3d[i]:add(-min):mul(1/(max-min))
	end
	
	img = image.toDisplayTensor(images3d, 2, imagesPerRow)
	return img
	
end

function saveWeights(modelParams, imagesPerRow, path, nepoch)
	for i, img in ipairs(modelParams) do
		image.savePNG(path .. '/layer' .. i .. '_weight_ep' .. nepoch .. '.png', normalizeImages(img))
	end
end

