function OtsuMethod(Dir, SmoothingMask)
% OtsuMethod(Dir, SmoothingMask)gets as input the directory of the images
% and applies the Otsu method saving the result in a new folder, 'Segmented
% Images'.

% Catharina Maria Hamer Holland - holland.cat@hotmail.com
% Christoffer Gøthgen - cgathg11@student.aau.dk
% Christos Zoupis Schoinas - xzoupis@gmail.com
% Andrew Janke - a.janke@gmail.com
% 
% Copyright 
% Catharina Maria Hamer Holland, Aalborg University.
% Christoffer Gøthgen, Aalborg University.
% Christos Zoupis Schoinas, Aalborg University.
% Andrew Janke, The University of Queensland.
% Permission to use, copy, modify, and distribute this software and its
% documentation for any purpose and without fee is hereby granted,
% provided that the above copyright notice appear in all copies.  The
% authors and the Universities make no representations about the
% suitability of this software for any purpose.  It is provided "as is"
% without express or implied warranty.

% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(fullfile(Dir, '/Cropped Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/OTSU Segmented Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

% For every image they are turned into gray scale, quantizes the gray scale
% image using specified quantization values contained in the N element 
% vector level which is the single threshold and then a median filter is
% applied for smoothing.
for im=1:length(Imgs)
    Image=imread(fullfile(fullfile(Dir, '/Cropped Images'), Imgs(im).name));
    iGray = rgb2gray(Image);
    level = multithresh(iGray);
    seg_I = imquantize(iGray,level);
    seg_smooth = medfilt2(seg_I, [SmoothingMask SmoothingMask]);

    for i=1:length(Image(:,1,:))
        for j=1:length(Image) 
            if seg_smooth(i,j)== 1 
                Image(i,j,:)= [0 0 0];
            end
        end
    end
  
    imwrite(Image, fullfile(NewFolder, Imgs(im).name));

end