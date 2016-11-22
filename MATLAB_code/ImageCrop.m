function ImageCrop(Dir)
% ImageCrop(Dir) gets as input the directory of the images, shows the
% middle image and wait for the user to select the cropping rectangular.
% When the user does so (right click + crop image) the function
% automatically crops all the images and saves them in a new folder called
% 'Cropped Images'.

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
Imgs = dir(fullfile(Dir, '*.png'));

% Getting the middle image and the cropping rectangle the user selected
MiddleImage = length(Imgs)/2;
ImageForRectangular=imread(fullfile(Dir, Imgs(MiddleImage).name));
[NotNeeded, rect] = imcrop(ImageForRectangular);

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Cropped Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

% Every image is cropped according to the cropping rectangle and saved with
% the same name into the new folder
for im=1:length(Imgs)
    Image=imread(fullfile(Dir, Imgs(im).name));

    Image = imcrop(Image,[rect(1),rect(2),rect(3),rect(4)]); 

    imwrite(Image, fullfile(NewFolder, Imgs(im).name));
end
