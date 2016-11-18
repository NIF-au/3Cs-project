#!/bin/bash

# Catharina Maria Hamer Holland - holland.cat@hotmail.com
# Christoffer Gøthgen - cgathg11@student.aau.dk
# Christos Zoupis Schoinas - xzoupis@gmail.com
# Andrew Janke - a.janke@gmail.com
# 
# Copyright 
# Catharina Maria Hamer Holland, Aalborg University.
# Christoffer Gøthgen, Aalborg University.
# Christos Zoupis Schoinas, Aalborg University.
# Andrew Janke, The University of Queensland.
# Permission to use, copy, modify, and distribute this software and its
# documentation for any purpose and without fee is hereby granted,
# provided that the above copyright notice appear in all copies.  The
# authors and the Universities make no representations about the
# suitability of this software for any purpose.  It is provided "as is"
# without express or implied warranty.


CT=$(zenity --file-selection --file-filter='*.nii' --title="Select the NifTi file with the CT images")

MRI=$(zenity --file-selection --file-filter='*.nii' --title="Select the NifTi file with the MR images")

export PATH=/usr/local/MATLAB/R2015a/bin:$PATH
matlab -nodesktop -nosplash -r "addpath /gv0/home/uqcgothg/Desktop/Nfiti; segment_stuff $CT; exit"

nii2mnc CT_blur.nii CTmnc.mnc

nii2mnc $MRI MRImnc.mnc

register CTmnc.mnc MRImnc.mnc

TRM=$(zenity --file-selection --title="Select the transformation matrix")

mincresample -like MRImnc.mnc -transformation $TRM CTmnc.mnc after_resample.mnc

mnc2nii after_resample.mnc NewCT.nii

RTMPATH=$(zenity --file-selection --directory --title="Select the directory to store the transformation matrix of the Rigid Registration" --filename=$HOME/Desktop/)

echo "Select the name of the transformation matrix"
read RTM

RNiiPATH=$(zenity --file-selection --directory --title="Select the directory to store the NifTi file from the Rigid Registration" --filename=$HOME/Desktop/)

echo "Select the name of the transformation matrix(do NOT forget the 'nii')"
read RNii

antsRegistration --dimensionality 3 --float 0 --output [$RTMPATH/$RTM, $RNiiPATH/$RNii] --interpolation Linear --winsorize-image-intensities [0.005,0.995] --use-histogram-matching 0 --transform Rigid[0.1] --metric MI[NewCT.nii,$MRI,1,32,Regular,0.25] --convergence [1000x500x250x100,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox --verbose

ATMPATH=$(zenity --file-selection --directory --title="Select the directory to store the transformation matrix of the Affine Registration" --filename=$HOME/Desktop/)

echo "Select the name of the transformation matrix"
read ATM

ANiiPATH=$(zenity --file-selection --directory --title="Select the directory to store the NifTi file from the Affine Registration" --filename=$HOME/Desktop/)

echo "Select the name of the transformation matrix(do NOT forget the 'nii')"
read ANii


antsRegistration --dimensionality 3 --float 0 --output [$ATMPATH/$ATM, $ANiiPATH/$ANii] --interpolation Linear --winsorize-image-intensities [0.005,0.995] --use-histogram-matching 0 --transform Affine[0.1] --metric MI[NewCT.nii, $RNiiPATH/$RNii,1,32,Regular,0.25] --convergence [1000x500x250x100,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox --verbose

STMPATH=$(zenity --file-selection --directory --title="Select the directory to store the transformation matrix of the SyN Registration" --filename=$HOME/Desktop/)

echo "Select the name of the transformation matrix"
read STM

SNiiPATH=$(zenity --file-selection --directory --title="Select the directory to store the NifTi file from the SyN Registration" --filename=$HOME/Desktop/)

echo "Select the name of the transformation matrix(do NOT forget the 'nii')"
read SNii

antsRegistration --dimensionality 3 --float 0 --output [$STMPATH/$STM, $SNiiPATH/$SNii] --interpolation Linear --winsorize-image-intensities [0.005,0.995] --use-histogram-matching 0 --transform SyN[0.1,3,0] --metric CC[NewCT.nii, $ANiiPATH/$ANii,1,4] --convergence [100x70x50x20,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox --verbose
