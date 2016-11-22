function segment_stuff(nii)

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

cd .. 
ct = load_nii(nii);
img = ct.img;

START = 1;
END = length(img(1,1,:));


pos = 1;
for sl = START:END

        I = img(:,:,sl);
      
        
        I = I-min(I(:));

        I= I/max(I(:));

        bw = im2bw(I);

        bw = im2double(bw);

        blur = imgaussfilt(bw,4);

        array3d(:,:,pos) = blur;
        pos=pos+1;
        
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
save_nii(nii_file, 'CT_blur.nii')
