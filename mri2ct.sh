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

cd MATLAB_code
export PATH=/usr/local/MATLAB/R2015a/bin:$PATH
matlab -nodesktop -nosplash -r "addpath /gv0/home/uqcgothg/Desktop/Nfiti; segment_stuff $CT; exit"
cd ..

nii2mnc CT_blur.nii CTmnc.mnc

nii2mnc $MRI MRImnc.mnc

register CTmnc.mnc MRImnc.mnc

TRM=$(zenity --file-selection --title="Select the transformation matrix")

mincresample -like MRImnc.mnc -transformation $TRM CTmnc.mnc after_resample.mnc

mnc2nii after_resample.mnc NewCT.nii

TMPATH=$(zenity --file-selection --directory --title="Select the directory to store the transformation matrices from the registrations" --filename=pwd)

echo "Select the name of the transformation matrix (will automatically be added in the end the transformation method that was used)"
read TMN

NiiPATH=$(zenity --file-selection --directory --title="Select the directory to store the NifTi files the registrations" --filename=pwd)

echo "Select the name of the transformation matrix(do NOT add '.nii' in the end)"
read Nii
parameters=$(zenity --forms --title="Add Parameters" --text="Remember not to use spaces after commas!" --separator="," --add-entry=$'Dimensionality\n(eg. 3)' --add-entry=$'float\n(eg. 0)' --add-entry=$'Interpolation\n(eg. Linear)' --add-entry=$'winsorize image intensities\n(eg. 0.005,0.995)' --add-entry=$'Use histogram matching\n(eg. 0)' --add-entry=$'Step size\n(eg. 0.1)' --add-entry=$'Metric\n(eg. 1 32 Regular 0.25)' --add-entry=$'Convergence\n(eg. 1000,500,250,100,1e-6,10)' --add-entry=$'Shrink Factors\n(eg. 8,4,2,1)' --add-entry=$'Smoothing sigmas\n(eg. 3,2,1,0)')
par=(${parameters//,/ })

extras=$(zenity --forms --title="Add extra parameters for SyN registration" --text="Remember not to use spaces after commas!" --separator="," --add-entry=$'transform\n(eg. 0.1,3,0)', --add-entry=$'Metric\n(eg. 1,4)' --add-entry=$'Convergence\n(eg. 100,70,50,20,1e-6,10)')
extra=(${extras//,/ })

antsRegistration --dimensionality ${par[1]} --float ${par[2]} --output [$TMPATH/${TMN}Rigid, $NiiPATH/${Nii}_Rigid.nii] --interpolation ${par[3]} --winsorize-image-intensities [${par[4]},${par[5]}] --use-histogram-matching ${par[6]} --transform Rigid[${par[7]}] --metric MI[NewCT.nii,$MRI,${par[8]},${par[9]}, ${par[10]}, ${par[11]}] --convergence [${par[12]}x${par[13]}x${par[14]}x${par[15]},${par[16]},${par[17]}] --shrink-factors ${par[18]}x${par[19]}x${par[20]}x${par[21]} --smoothing-sigmas ${par[22]}x${par[23]}x${par[24]}x${par[25]}vox --verbose

antsRegistration --dimensionality ${par[1]} --float ${par[2]} --output [$TMPATH/${TMN}_Affine, $NiiPATH/${Nii}_Affine.nii] --interpolation ${par[3]} --winsorize-image-intensities [${par[4]},${par[5]}] --use-histogram-matching ${par[6]} --transform Affine[${par[7]}] --metric MI[NewCT.nii, $NiiPATH/${Nii}_Rigid.nii,${par[8]},${par[9]}, ${par[10]}, ${par[11]}] --convergence [${par[12]}x${par[13]}x${par[14]}x${par[15]},${par[16]},${par[17]}] --shrink-factors ${par[18]}x${par[19]}x${par[20]}x${par[21]} --smoothing-sigmas ${par[22]}x${par[23]}x${par[24]}x${par[25]}vox --verbose

antsRegistration --dimensionality ${par[1]} --float ${par[2} --output [$TMPATH/${TMN}_SyN, $NiiPATH/${Nii}_SyN.nii] --interpolation ${par[3]} --winsorize-image-intensities [${par[4]},${par[5]}] --use-histogram-matching ${par[6]} --transform SyN[${extra[1]},${extra[2]},${extra[3]}] --metric CC[NewCT.nii, $NiiPATH/${Nii}_Affine.nii,${extra[4]},${extra[5]}] --convergence [${extra[6]}x${extra[7]}x${extra[8]}x${extra[9]}, ${extra[10]},${extra[11]}] --shrink-factors ${par[18]}x${par[19]}x${par[20]}x${par[21]} --smoothing-sigmas ${par[22]}x${par[23]}x${par[24]}x${par[25]}vox --verbose
