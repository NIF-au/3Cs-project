function Segment(Dir)

% Dir: The directory with the raw images. 
%       Example: 'C:\Users\vz017903\Desktop\img_png_resized'
% SmoothingMask: The mask used for smoothing, default value is 11
% Default Folder names:  - Cropped Images
%                          - Segmented Images
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
      '4. Contrast Stretch Images\n5. Sharpen Images\n6. All of the above\n7.Exit this menu\n' ]));

SmoothingMask = 11;

if any(x>7) || any(x<1)
   disp('Wrong choice(s)')
   return
elseif any(x==7)
    return
end

if any(x==6) && length(x)>1
   disp('\nYou cannot select the 6th option in combination with others')
   return

end



for i=1:length(x)
    if x(i) == 1 || x(i) == 6
        ImageCrop(Dir)
    end
    if  x(i) == 2 || x(i) == 6
        CMYKMethod(Dir, SmoothingMask)
    end
    if  x(i) == 3 || x(i) == 6
        ImageAligning(Dir)
    end
    if  x(i) == 4 || x(i) == 6
        ContrastStretch(Dir)
    end
    if  x(i) == 5 || x(i) == 6
        SharpenImage(Dir)
    end
end
