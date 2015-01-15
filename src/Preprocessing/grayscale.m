src_folder = '/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Train/Images/original';
dst_folder = '/home/brij/Documents/IIIT/courses/SMAI/Project/SignLanguageDetection/data/Train/Images/128x128_gray';

classesDir = dir(src_folder);
      
for i=1:size(classesDir,1)

    if(~strcmp(classesDir(i).name, '.') && ~strcmp(classesDir(i).name, '..') )

        classDirName = [src_folder '/' classesDir(i).name];
        dstDirName = [dst_folder '/' classesDir(i).name];
        classDir = dir(classDirName);

        for j=1:size(classDir, 1)
            if(~strcmp(classDir(j).name, '.') && ~strcmp(classDir(j).name, '..'))
                imageName = [classDirName '/' classDir(j).name];
                img = imread(imageName);
                img_gray = rgb2gray(img);
                imageName = [dstDirName '/' classDir(j).name ];
                imwrite(img_gray, imageName);
            end
        end
    end
end
