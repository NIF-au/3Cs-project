function SharpenImage(Dir)
% SharpenImage(Dir) gets as input the directory of the images and sharpens
% the images saving them in a new folder, 'Sharpened Images'.

% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(fullfile(Dir, '/Contrast Stretched Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Sharpened Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

for im=1:length(Imgs)
    
    Image=imread(fullfile(fullfile(Dir, '/Contrast Stretched Images'), Imgs(im).name));
    
    New_Image = imsharpen(Image, 'Radius', 3, 'Amount',1);
    
    imwrite(New_Image, fullfile(NewFolder, Imgs(im).name))
end