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

choice=0
out_dir=" "
inputsOK=(0 0 0 0 0)
menu=("1. Set Transformation Matrix Name" "2. Set Registered Image Name" "3. Select transformation method" "4. Select fixed images" "5. Select moving images")

while [ $choice -ne 6 ] -a [] 
do
        echo "Please select the input you want to add:
              WARNING: Make sure the paths do not include spaces or parentheses!!"


        for (( i=0; i<${#inputsOK[@]}; i++ ));
        do
          if [ ${inputsOK[i]} -eq 0 ]
          then
              echo ${menu[i]}

          else

              echo "${menu[i]} ..........ok"

          fi
        done
        echo    "6. Exit"

        read choice

        case $choice  in

        1)

                if [[ $out_dir != *[!\ ]* ]]
                then
                        out_dir=$(zenity --file-selection --directory --title="Select the path for the output files" --filename=pwd)
                fi
                echo "Enter the Transformation Matrix name"
                read TMN
                if [[ $out_dir = *[!\ ]* ]]  &&  [[ $TMN = *[!\ ]* ]]
                then
                        inputsOK[0]=1
                fi;;

        2)

                if [[ $out_dir != *[!\ ]* ]]
                then
                        out_dir=$(zenity --file-selection --directory --title="Select the path for the output files" --filename=pwd)
                fi
                echo "Enter the name for the registered image name (don't forget the .nii in the end) "
                read RIN
                if [[ $out_dir = *[!\ ]* ]]  &&  [[ $RIN = *[!\ ]* ]]
                then
                        inputsOK[1]=1
                fi;;

        3)

                method=$(zenity --list --width=500 --height=250 --title="Select Transformation method" --column="Methods" Rigid Affine SyN)
                if [[ $method = *[!\ ]* ]]
                then
                        inputsOK[2]=1
                fi;;
        4)

                fixed=$(zenity --file-selection --file-filter='*.nii' --title="Select the fixed images" --filename=pwd)
                if [[ $fixed = *[!\ ]* ]]
                then
                        inputsOK[3]=1
                fi;;

        5)

                moving=$(zenity --file-selection --file-filter='*.nii' --title="Select the moving images" --filename=pwd)
                if [[ $moving = *[!\ ]* ]]
                then
                        inputsOK[4]=1
                fi;;

        6)

                echo Cheers!;;

        *)

                echo "Wrong Choice, try again";;
        esac

done

if [ $choice -ne 6]
then
        if [ $method -eq 'SyN']
        then
	        parameters=$(zenity --forms --title="Add Parameters" --text="Remember not to use spaces after commas!" --separator="," --add-entry=$'Dimensionality\n(eg. 3)' --add-entry=$'float\n(eg. 0)' --add-entry=$'Interpolation\n(eg. Linear)' --add-entry=$'winsorize image intensities\n(eg. 0.005,0.995)' --add-entry=$'Use histogram matching\n(eg. 0)' --add-entry=$'Num_transform\n(eg. 0.1,3,0)' --add-entry=$'Convergence\n(eg. 100,70,50,20,1e-6,10)' --add-entry=$'Metric\n(eg. 1,4)' --add-entry=$'Shrink Factors\n(eg. 8,4,2,1)' --add-entry=$'Smoothing sigmas\n(eg. 3,2,1,0)')

                antsRegistration --dimensionality ${par[1]} --float ${par[2]} --output [$out_dir/$TMN,$out_dir/RIN] --interpolation ${par[3]} --winsorize-image-intensities [${par[4]}, ${par[5]}] --use-histogram-matching ${par[6]} --initial-moving-transform [$fixed, $moving, 1] --transform $method[${par[6]}, ${par[7]}, ${par[8]}] --metric CC[$fixed,$moving,${par[9]},${par[10]}] --convergence [${par[11]}x${par[12]}x${par[13]}x${par[14]},${par[15]},${par[16]}] --shrink-factors ${par[17]}x${par[18]}x${par[19]}x${par[20]} --smoothing-sigmas ${par[21]}x${par[22]}x${par[22]}x${par[23]}vox --verbose

        else
                parameters=$(zenity --forms --title="Add Parameters"  --separator="," --add-entry="Dimensionality" --entry-text "test" --add-entry="float" --add-entry="Interpolation" --add-entry="winsorize image intensities" --add-entry="Use histogram matching" --add-entry="Step Size" --add-entry="Convergence" --add-entry="Metric" --add-entry="Shrink Factors" --add-entry="Smoothing sigmas")

                antsRegistration --dimensionality ${par[1]} --float ${par[2]} --output [$out_dir/$TMN,$out_dir/RIN] --interpolation ${par[3]} --winsorize-image-intensities [${par[4]}, ${par[5]}] --use-histogram-matching ${par[6]} --initial-moving-transform [$fixed, $moving, 1] --transform $method[${par[6]}] --metric MI[$fixed,$moving,${par[7]},${par[8]},${par[9]},${par[10]}] --convergence [${par[11]}x${par[12]}x${par[13]}x${par[14]},${par[15]},${par[16]}] --shrink-factors ${par[17]}x${par[18]}x${par[19]}x${par[20]} --smoothing-sigmas ${par[21]}x${par[22]}x${par[22]}x${par[23]}vox --verbose
        fi
fi

