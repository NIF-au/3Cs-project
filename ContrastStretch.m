function ContrastStretch(Dir)
% ContrastStretch(Dir) gets as input the directory of the images and
% applies contrast stretching to all images using histogram equalization
% and saving the new images in a new folder, 'Contrast Stretched Images'.



% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(fullfile(Dir, '/Aligned Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/Contrast Stretched Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end


for im=1:length(Imgs)
    
    Image=imread(fullfile(fullfile(Dir, '/Aligned Images'), Imgs(im).name));
    
    New_Image = adapthisteq(Image,'Distribution', 'uniform');
    
    imwrite(New_Image, fullfile(NewFolder, Imgs(im).name));
    
end