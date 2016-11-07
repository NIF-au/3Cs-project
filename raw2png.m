function raw2png(Dir, extension)
% raw2png(Dir, extension) converts the raw file with the extension given 
% from the directory given to png files. The png files are saved in the
% same directory and then are resized in the 25% of their original size.
% ImageMagick needs to be installed for this script to work, can be found
% here: http://www.imagemagick.org/script/binary-releases.php 

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

dos(['mogrify -format png ' Dir '/*.' extension]);

dos(['mogrify -resize 25% *.' extension]);