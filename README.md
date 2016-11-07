# Contrast Enhancement Registration Algorithm (CERA) 

This project was made with a focus on contrast stretching of blockface images, stacking and registration. With the code you are able to:

- Convert images from RAW to png and with a resize of 25 % 
- Semi manual cropping of the images 
- Segmentation of the brain with either converting the images to CMYK and performing an Otsu on the mergenta channel or performing an Otsu on the original PNG image
- Simple alignment with translation 
- Contrast enhancement with the method CLAHE together with a sharpening of the images 
- Stacking of the images with defined dimensions and creation of nifti files
- Rigid, Affine and SyN registraion with options to change parameters

To run the project, simply run CMenu in MATLAB.

# Software requirements

The code use several external software, so for it to be able to run following software need to be installed: 

- MATLAB 2015 or older with image processing toolbox. Problems with MATLAB 2016 has been experienced so we recommend using older versions.
- Advanced Normalization Tools (ANTs) by stnava. Can be found here: http://stnava.github.io/ANTs/
- ImageMagick. Can be found here: http://www.imagemagick.org/script/binary-releases.php
- Tools for NIfTI and ANALYZE image. Can be found here: https://se.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image
- MINC toolkit version 1.9.11. Can be found here: https://bic-mni.github.io/#v2-version-19111911

# License

Catharina Maria Hamer Holland - holland.cat@hotmail.com
Christoffer Gøthgen - cgathg11@student.aau.dk
Christos Zoupis Schoinas - xzoupis@gmail.com
Andrew Janke - a.janke@gmail.com

Copyright 
Catharina Maria Hamer Holland, Aalborg University.
Christoffer Gøthgen, Aalborg University.
Christos Zoupis Schoinas, Aalborg University.
Andrew Janke, The University of Queensland.
Permission to use, copy, modify, and distribute this software and its documentation for any purpose and without fee is hereby granted, provided that the above copyright notice appear in all copies.  The authors and the Universities make no representations about the suitability of this software for any purpose.  It is provided "as is" without express or implied warranty.
