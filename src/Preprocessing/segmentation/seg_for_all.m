function seg_for_all(inputPath)

    %%
    skin_seg_fol_n = [inputPath, '/../color_seg_images'];
    mkdir(skin_seg_fol_n);
    
    %%
    classDir            = dir(inputPath);
     
    %%
    numFol = size(classDir, 1) ;
    for i=3:numFol
        class_name = classDir(i).name;
        newFol_n = [skin_seg_fol_n '/' class_name];
        mkdir(newFol_n);
        oldFol_n = [inputPath '/' class_name];
        
        samples = dir(oldFol_n);
        numSamples = size(samples, 1);
        
        for j=3:numSamples
            sample_name = samples(j).name;
            img_name = [oldFol_n '/' sample_name];
            o_img = segmentation(img_name);
            o_img_name = [newFol_n '/' sample_name];
            imwrite(o_img, o_img_name);            
        end
        
    end
    
end