for i=1,nImages do
    samples.data[i] = image.rgb2nrgb(samples.data[i])
end

torch.save(rgbnorm_dataPath,samples)

