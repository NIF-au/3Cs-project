function Resampling(Dir ,selection)
% Resampling(Dir) creates a 3d array with the images from the directory
% given and then changes the size of the matrix according to the input the
% user gives saving with the chosen name as a NifTi file.

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



%%
if selection == 3
    % Saving the list of .png files of the given Dir in the Imgs variable
    Imgs = dir(fullfile(Dir, '*.png'));
    for_print_only = imread(fullfile(Dir, Imgs(1).name));
    print_x = num2str(length(for_print_only(:,1,1)));
    print_y = num2str(length(for_print_only(1,:,1)));
    print_z = num2str(length(Imgs));
    
    %valta se kamia metavlhth gia na mhn kaneis oti kaneis sto 41
else
    mri = load_nii(Dir);
    Imgs = mri.img;
    print_x = num2str(length(Imgs(:,1,1)));
    print_y = num2str(length(Imgs(1,:,1)));
    print_z = num2str(length(Imgs(1,1,:)));
end

%=================================MENU====================================%
prompt = {'Resampling dimensions', 'Voxel size', 'New file name'};
dlg_title = 'Enter the parameter values';
num_lines = 1;
defaultans = {[print_x, ' ', print_y, ' ', print_z], '0.015 0.021 0.021' [pwd, 'New.nii']};
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


pos = 1;
for slice = length(Imgs): -1 : 1
        if selection == 3
            thisSlice=imread(fullfile(Dir, Imgs(slice).name));
        else
            I = img(:,:,slice);

            % shift data such that the smallest element of A is 0
            I=I-min(I(:));                                                  

            % normalize the shifted data to 1
            thisSlice=I/max(I(:));
        end
        array3d(:,:,pos) = thisSlice;
        pos = pos + 1;
end

array3d = im2double(array3d);
mat_rs = resize(array3d, [x y z]);

nii_file = make_nii(mat_rs, [vox1, vox2, vox3]);
save_nii(nii_file, nii_name)