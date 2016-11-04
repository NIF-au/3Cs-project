function CMYKMethod(Dir, SmoothingMask)
% CMYKMethod(Dir, SmoothingMask) gets the Dir with the images, converts
% them into CMYK format and processes only the magenta channel in order to
% get the segmented images and save them in a new folder, 'CMYK Segmented
% Images'.

% Create color transformation structure
C = makecform('srgb2cmyk');

% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(fullfile(Dir, '/Cropped Images'), '*.png'));

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/CMYK Segmented Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

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

     
     imwrite(Image, fullfile(NewFolder, Imgs(im).name));
end