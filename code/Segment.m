function Segment(Dir)

% Dir: The directory with the raw images. 
%       Example: 'C:\Users\vz017903\Desktop\img_png_resized'
% SegmentMethod: - 'otsu' for applying the Otsu Method
%                - 'cmyk' for applying the CMYK Method
% SmoothingMask: The mask used for smoothing, default value is 7
% Default Folder names:  - Cropped Images
%                          - Otsu / CMYK Segmented Images
%                          - Aligned Images
%                          - Contrast Stretched Images
%                          - Sharpened Images
% They will all be created automatically if they are not already there. 
% If they are, the folders are first cleared.

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

x=input(sprintf (['\nPlease select which of the following functions you want to use:\n' ...
      '(if you choose more than one option, put the options in brackets! Eg. [1 3 5])\n' ...
      '1. Crop Images\n2. Segment Images\n3. Align Images\n' ...
      '4. Contrast Stretch Images\n5. Sharpen Images\n6. All of the above\n' ]));

if any(x>6) || any(x<1)
   disp('Wrong choice(s)')
   return
end

if any(x==6) && length(x)>1
   disp('\nYou cannot select the 6th option in combination with others')
   return
elseif any(x==2) || any(x==3 || any(x==6))
   SegmentMethod=input(sprintf (['\nSelect one of the following methods:\n' ...
       'For OTSU method: otsu\nFor CMYK method: cmyk\n']), 's');
   
   answer=input(sprintf (['\nDefault smoothing mask size is [7 7], do you want to change it? [y/n]:']), 's');
   if strcmpi(answer, 'y')
       SmoothingMask=input(sprintf (['\nInsert number for the size...\n']));
   elseif strcmpi(answer, 'n')
       SmoothingMask = 7;
   else
       disp('\nWrong Input')
       return
   end
end

if ~(strcmpi(SegmentMethod,'otsu') || strcmpi(SegmentMethod,'cmyk'))
   disp('\nError. SegmentMethod needs to be either ''otsu'' or ''cmyk''. Type help Segment for more information!')
   return
end


for i=1:length(x)
    if x(i) == 1 || x(i) == 6
        ImageCrop(Dir)
    end
    if  x(i) == 2 || x(i) == 6
        if strcmpi(SegmentMethod,'otsu')
            OtsuMethod(Dir, SmoothingMask)
        else
            CMYKMethod(Dir, SmoothingMask)
        end
    end
    if  x(i) == 3 || x(i) == 6
        ImageAligning(Dir, SegmentMethod)
    end
    if  x(i) == 4 || x(i) == 6
        ContrastStretch(Dir)
    end
    if  x(i) == 5 || x(i) == 6
        SharpenImage(Dir)
    end
end