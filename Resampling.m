function Resampling(Dir)
% Resampling(Dir) creates a 3d array with the images from the directory
% given and then changes the size of the matrix according to the input the
% user gives saving with the chosen name as a NifTi file.


%=================================MENU====================================%
prompt = {'Resampling dimensions', 'Voxel size', 'New file name'};
dlg_title = 'Enter the parameter values';
num_lines = 1;
defaultans = {'600 1200 300', '0.015 0.021 0.021' [pwd, 'New.nii']};
answer = inputdlg(prompt,dlg_title,[1, 50],defaultans);
%=========================================================================%

%% parameters
xyz = answer(1);
xyz = str2num(xyz{:});
x = xyz(1);
y = xyz(2);
z = xyz(3);

vox = answer(2);
vox = str2num(vox{:});
vox1 = vox(1);
vox2 = vox(2);
vox3 = vox(3);

nii_name = answer{3};

%%

% Saving the list of .png files of the given Dir in the Imgs variable
Imgs = dir(fullfile(Dir, '*.png'));

for slice = length(Imgs): -1 : 1
        thisSlice=imread(fullfile(Dir, Imgs(slice).name));
        array3d(:,:,slice) = thisSlice;
end

array3d = im2double(array3d);
mat_rs = resize(array3d, [x y z]);

nii_file = make_nii(mat_rs, [vox1, vox2, vox3]);
save_nii(nii_file, nii_name)