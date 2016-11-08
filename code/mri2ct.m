function mri2ct()

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
PATH = getenv('PATH');
setenv('PATH', [PATH ':/data/lfs2/software/ubuntu14/minc-itk4-1.9.11-20160202/bin']);

LIB = getenv('LD_LIBRARY_PATH');
setenv('LD_LIBRARY_PATH', [LIB ':/data/lfs2/software/ubuntu14/minc-itk4-1.9.11-20160202/lib']);

fprintf('Select the NifTi file with the CT images\n')
[CTName,ctpath] = uigetfile('*.nii','Select the NifTi file with CT images');

fprintf('Select the NifTi file with the MR images\n')
[MRIName,mripath] = uigetfile('*.nii','Select the  NifTi file with the MR images');

dos(['nii2mnc ' fullfile(ctpath, CTName) ' CTmnc.mnc']);

dos(['nii2mnc ' fullfile(mripath, MRIName) ' MRImnc.mnc']);

dos('register MRImnc.mnc CTmnc.mnc');


fprintf('Select the NifTi file with the MR images\n')
[trName,trpath] = uigetfile('*','Select the  NifTi file with the MR images');

dos(['export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH; mincresample -like MRImnc.mnc -transformation ' fullfile(trpath, trName), ...
    ' CTmnc.mnc after_resample.mnc']);

dos('mnc2nii after_resample.mnc NewCT.mnc');

ct = load_nii (fullfile(ctpath, CTName));
img = ct.img;

pos = 1;
for sl = length(img(1,1,:)):1
        I = img(:,:,sl);

        bw = im2bw(I);

        bw = im2double(bw);

        array3d(:,:,pos) = bw;
        pos = pos + 1;
end
array3d = im2double(array3d);

prompt = {'Voxel size'};
dlg_title = 'Enter the voxel size';
defaultans = {'1 1 1'};
answer = inputdlg(prompt,dlg_title,[1 50],defaultans);

vox = answer(1);
vox = str2num(vox{:});
vox1 = vox(1);
vox2 = vox(2);
vox3 = vox(3);

nii_file = make_nii(array3d, [vox1, vox2, vox3]);
save_nii(nii_file, 'CTmask.nii')

dos('nii2mnc CTmask.nii CTmask_mnc.mnc');

dos('register MRImnc.mnc CTmask_mnc.mnc');

fprintf('Select the NifTi file with the MR images\n')
[tr2Name,tr2path] = uigetfile('*','Select the  NifTi file with the MR images');

dos(['export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH; mincresample -like MRImnc.mnc -transformation ' fullfile(tr2path, tr2Name), ...
    ' CTmask_mnc.mnc after_2resample.mnc']);

dos('mnc2nii after_2resample.mnc NewCT2.mnc');