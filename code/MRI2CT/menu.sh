#!/bin/bash

choice=0
out_dir=" "
inputsOK=(0 0 0 0 0)
menu=("1. Set Transformation Matrix Name" "2. Set Registered Image Name" "3. Select transformation method" "4. Select fixed images" "5. Select moving images")

while [ $choice -ne 6 ]  
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
	echo	"6. Exit"

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
