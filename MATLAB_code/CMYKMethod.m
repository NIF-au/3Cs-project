function CMYKMethod(Dir, SmoothingMask)
% CMYKMethod(Dir, SmoothingMask) gets the Dir with the images, converts
% them into CMYK format and performes Otsu only the magenta channel in 
% order to get the segmented images and save them in a new folder, 
% 'CMYK Segmented Images'. A median filter is applied to the mask with a 
% default neighborhood of [7 7].

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


% Create color transformation structure
C = makecform('srgb2cmyk');

% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(fullfile(Dir, '/Cropped Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Segmented Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

% Creates a mask on the magenta channel, applying a median filter and use 
% the mask on the image.
for im=1:length(Imgs)
     Image=imread(fullfile(fullfile(Dir, '/Cropped Images'), Imgs(im).name));
     hcmyk = applycform(Image,C);
     
     hchan2 = hcmyk(:,:,2);
     
     hlevel2 = multithresh(hchan2);
     
     hsegchan2 = imquantize(hchan2,hlevel2);
     
     smooth_cmyk2 = medfilt2(hsegchan2, [SmoothingMask SmoothingMask]);

     for i=1:length(Image(:,1,:)) 
        for j=1:length(Image) 
            if smooth_cmyk2(i,j)~= 1 
                Image(i,j,:)= [0 0 0];
            end
        end
     end

     
     imwrite(Image, fullfile(NewFolder, Imgs(im).name)); % save image
end
