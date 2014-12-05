function main(inputPath)

    classesDir = dir(inputPath);
      
    for i=1:size(classesDir,1)

            disp('seriously');
        
        if(~strcmp(classesDir(i).name, '.') && ~strcmp(classesDir(i).name, '..') )

            classDirName = [inputPath '/' classesDir(i).name];
            classDir = dir(classDirName);
            
            for j=1:size(classDir, 1)
                if(~strcmp(classDir(j).name, '.') && ~strcmp(classDir(j).name, '..'))
                    imageName = [classDirName '/' classDir(j).name];
                    img = imread(imageName);
                    [sobelX, sobelY] = pngToSobel(img);
                    delimiter = '.';
                    C = strsplit(classDir(j).name,delimiter);
                    imageNameX = [classDirName '/' C{1} '_sobelX.png' ];
                    imageNameY = [classDirName '/' C{1} '_sobelY.png' ];
                    imwrite(sobelX, imageNameX);
                    imwrite(sobelY, imageNameY);
                end
            end
            
        end
    end


end