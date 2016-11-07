function ImageAligning(Dir, SegmentMethod)
% ImageAligning(Dir, SegmentMethod) get the Dir of the images and aligns
% each one with the previous image.
% SegmentMethod is required for selecting the right folder with the images
% depending on the segmentation method used before.

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


% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Aligned Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

if strcmpi(SegmentMethod,'otsu')
    Dir = fullfile(Dir, '/OTSU Segmented Images');
else
    Dir = fullfile(Dir,'/CMYK Segmented Images');
end

% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(Dir, '*.png'));


% Setting up the first image to be the fixed 
fixed=imread(fullfile(Dir, Imgs(1).name));
fixed = rgb2gray(fixed);

Al_img(1).name = fixed;
imwrite(Al_img(1).name, fullfile(NewFolder, Imgs(1).name)); % save image

% Making a transformation by translation where the images before is set to
% the fixed and the next is set as the moving. 
for im = 2:length(Imgs)

    fixed = Al_img(im-1).name;

    [moving,map] = imread(fullfile(Dir, Imgs(im).name));
    moving = rgb2gray(moving);
    
    [optimizer, metric] = imregconfig('monomodal');

    
    tform = imregtform(moving, fixed, 'translation', optimizer, metric);
    movingRegistered = imwarp(moving,tform,'OutputView',imref2d(size(fixed)));
    Al_img(im).name=movingRegistered;
    Al_img(im).map = map;
    

    
   imwrite(Al_img(im).name, fullfile(NewFolder, Imgs(im).name)); %save image
    
end


