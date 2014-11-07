function img = segmentation(inputPath)

       %% 
       %hsv segmentation
       img_orig=imread(inputPath);
       img=img_orig; %copy of original image
       hsv=rgb2hsv(img);
       h=hsv(:,:,1);
       s=hsv(:,:,2);

       [r c v]=find(h>0.25 | s<=0.15 | s>0.9); %non skin
       numid=size(r,1);

       for i=1:numid
           img(r(i),c(i),:)=0;
       end

       %figure
       %imshow(img);


       %%
       %ycbcr segmentation
       img_ycbcr=img;  %image from the previous segmentation
       ycbcr=rgb2ycbcr(img_ycbcr);
       cb=ycbcr(:,:,2);
       cr=ycbcr(:,:,3);


        %Detect Skin
        %[r,c,v] = find(cb>=77 & cb<=127 & cr>=133 & cr<=173);
         [r c v] = find(cb<=77 | cb >=127 | cr<=133 | cr>=173);
        numid = size(r,1);

        %Mark Skin Pixels
        for i=1:numid
            img_ycbcr(r(i),c(i),:) = 0;
           % bin(r(i),c(i)) = 1;
        end

        %figure
        %title('ycbcr segmentation');
       %imshow(img_ycbcr);



      %%
      %rgb segmentation

    img_rgb=img_orig;
    r=img_rgb(:,:,1);
    g=img_rgb(:,:,2);
    b=img_rgb(:,:,3);


    [row col v]= find(b>0.79*g-67 & b<0.78*g+42 & b>0.836*g-14 & b<0.836*g+44 ); %non skin pixels
    numid=size(row,1);

    for i=1:numid
        img_rgb(row(i),col(i),:)=0;
    end

    %figure
    %imshow(img_ycbcr);
    %figure
    %imshow(img_rgb);

end