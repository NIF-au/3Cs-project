function ImageAligning(Dir, SegmentMethod)
% ImageAligning(Dir, SegmentMethod) get the Dir of the images and aligns
% each one with the previous image.
% SegmentMethod is required for selecting the right folder with the images
% depending on the segmentation method used before.

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



fixed=imread(fullfile(Dir, Imgs(1).name));
fixed = rgb2gray(fixed);

Al_img(1).name = fixed;
imwrite(Al_img(1).name, fullfile(NewFolder, Imgs(1).name));


for im = 2:length(Imgs)

    fixed = Al_img(im-1).name;

    [moving,map] = imread(fullfile(Dir, Imgs(im).name));
    moving = rgb2gray(moving);
    
    [optimizer, metric] = imregconfig('monomodal');

    
    tform = imregtform(moving, fixed, 'translation', optimizer, metric);
    movingRegistered = imwarp(moving,tform,'OutputView',imref2d(size(fixed)));
    Al_img(im).name=movingRegistered;
    Al_img(im).map = map;
    

    
   imwrite(Al_img(im).name, fullfile(NewFolder, Imgs(im).name));
    
end


