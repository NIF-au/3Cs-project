function ContrastStretch(Dir)
% ContrastStretch(Dir) gets as input the directory of the images and
% applies contrast stretching to all images using Contrast-limited adaptive 
% histogram equalization (CLAHE) and saving the new images in a new folder,
% 'Contrast Stretched Images'.

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
Imgs = dir(fullfile(fullfile(Dir, '/Aligned Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Contrast Stretched Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

% Applying CLAHE with default cliplimit and uniform histogram and saving images
for im=1:length(Imgs)
    
    Image=imread(fullfile(fullfile(Dir, '/Aligned Images'), Imgs(im).name));
    
    New_Image = adapthisteq(Image,'Distribution', 'uniform');
    
    imwrite(New_Image, fullfile(NewFolder, Imgs(im).name));
    
end