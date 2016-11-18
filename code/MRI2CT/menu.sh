#!/bin/bash

declare -i choice=0
declare out_dir=" ";
declare -a inputsOK=(0 0 0 0 0 0)
declare -a menu=("1. Set Transformation Matrix Name" "2. Set Registered Image Name" "3. Select transformation method" "4. Select fixed images" "5. Select moving images" "6. Choose Metric")

while [ $choice -ne 7 ]  
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
	echo	"7. Exit"

	read choice

	case $choice  in

	1)

		echo "1s choice $choice";;

	2)

		echo "2";;

	3)

		echo 3;;

	4)

		echo 4;;

	5) 

		echo 5;;	

	6)	

		echo 6;;

	7)

		echo 7;;

	*)

		echo "Wrong Choice, try again";;
	esac

done
