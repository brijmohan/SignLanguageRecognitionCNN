function [X_2x, X_x, Y] = createMatFile(inputPath)
    
    classesDir = dir(inputPath);
    classLableMap = classLabels();
    scale_2x = [100 100];
    scale_x    = [32 32];

    numOfSamples = 0;
    
    %% Iterate over all 26 folders and store data
    for i=1:size(classesDir,1)

        if(~strcmp(classesDir(i).name, '.') && ~strcmp(classesDir(i).name, '..') )

            classDirName = [inputPath '/' classesDir(i).name];
            classDir = dir(classDirName);
            
            for j=1:size(classDir, 1)
                if(~strcmp(classDir(j).name, '.') && ~strcmp(classDir(j).name, '..'))
                    numOfSamples = numOfSamples + 1;
                end
            end
            
        end
    end
    
    %%
    X_2x = zeros(scale_2x(1,1), scale_2x(1,2), 3, numOfSamples);
    X_x = zeros(scale_x(1,1), scale_x(1,2), 3, numOfSamples);
    
    Y = zeros(numOfSamples, 1);
    
    %%
    sampleNum = 0;
    for i=1:size(classesDir,1)

        if(~strcmp(classesDir(i).name, '.') && ~strcmp(classesDir(i).name, '..') )

            classDirName = [inputPath '/' classesDir(i).name];
            classDir = dir(classDirName);
            
            for j=1:size(classDir, 1)
                if(~strcmp(classDir(j).name, '.') && ~strcmp(classDir(j).name, '..'))
                    sampleNum = sampleNum + 1;
                    
                    imageName = [classDirName '/' classDir(j).name];
                    img = imread(imageName);
                    img_2x = imresize(img, scale_2x);
                    img_x    = imresize(img, scale_x);
                    
                    X_2x(:, :, :, sampleNum) = img_2x;
                    X_x(:, :, :, sampleNum) = img_x;
                    
                    Y(sampleNum,1) = classLableMap(classesDir(i).name);
                    
                end
            end
            
        end
    end
    
end