function SharpenImage(Dir)
% SharpenImage(Dir) gets as input the directory of the images and sharpens
% the images saving them in a new folder, 'Sharpened Images'.

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
Imgs = dir(fullfile(fullfile(Dir, '/Contrast Stretched Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Sharpened Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

% Sharpen image with radius of 3 and amount 1 
for im=1:length(Imgs)
    
    Image=imread(fullfile(fullfile(Dir, '/Contrast Stretched Images'), Imgs(im).name));
    
    New_Image = imsharpen(Image, 'Radius', 3, 'Amount',1);
    
    imwrite(New_Image, fullfile(NewFolder, Imgs(im).name))
end
