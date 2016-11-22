function CMenu

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

cd([pwd '/MATLAB_code']);

x=0;
while x~=6
    %===================================MENU==============================%
    x = input(sprintf (['\nSelect one of the following functions you want to use:\n' ...
          '1. Convert RAW file to PNG\n2. Segmentation Menu\n3. Blockface Resize\n' ...
          '4. MRI Resize\n5. Exit\n']));
    %=====================================================================%
    if x<1 || x>5
        disp('Wrong choice')
        return
    elseif x==1
        fprintf('Select the path of the RAW image files\n')
        out_dir = uigetdir(pwd, 'Select the path of the RAW image files');

        extension = input(sprintf('Type the extension of the RAW image files: '), 's');
        
        raw2png(out_dir, extension)
    elseif x==2
        fprintf('Select the path of the image files\n')
        out_dir = uigetdir(pwd, 'Select the path of the image files');
        Segment(out_dir)
    elseif x==3 || x==4
        if x == 4
            fprintf('Select the MR images\n')
            [FileName,mripath] = uigetfile('*.nii','Select the MR images');
            Dir = fullfile(mripath, FileName);
        else
            fprintf('Select the path of the image files\n')
            Dir = uigetdir(pwd, 'Select the path of the image files');
        end
        
        Resampling(Dir, x)

    else
        cd '..'
        return
    end
    fprintf('\n\nDone...........\n')
end
