function [NewFolder] =  MRIpreparation(Dir, FileName)
% MRIpreparation(Dir, FileName) gets a NifTi file and its path and save
% each slice an image in a new folder, 'MR Images'.

mri = load_nii (fullfile(Dir,FileName));
img = mri.img;

% Checking if the folder exists, if not it is created
NewFolder = strcat(Dir,'/MR Images');
if exist(NewFolder)==0
    mkdir(NewFolder)
else
    delete(fullfile(NewFolder,'*'));
end

for sl = 1:length(img(1,1,:))
I = img(:,:,sl);

% shift data such that the smallest element of A is 0
I=I-min(I(:));                                                  

% normalize the shifted data to 1
I=I/max(I(:));

imwrite(I, fullfile([NewFolder 'mr_img_' num2str(sl) '.png']));
end
