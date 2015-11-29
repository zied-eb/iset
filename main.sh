#! /bin/bash

cd $(dirname $0)
. ./lib/prerequisites.sh
clear

PRE_check_device
locat=`pwd`
time=`date +%T`

echo -e "\n"
PS3='Please choose the debugging level for test execution: '
options=("Quiet mode    [ Level0 : No logs ]" "Normal mode   [ Level1 : Normal output ]" "Verbose mode  [ Level2 : Logs and input commands displayed ]" "Quit")

select verb in "${options[@]}"
do
	case $REPLY in
		1) ./Marvin.sh 1 $dut1 $locat $time && break ;;
		2) ./Marvin.sh 2 $dut1 $locat $time && break ;;
		3) ./Marvin.sh 3 $dut1 $locat $time && break ;;
		4) break ;;
		*) echo "Bad choice !" ;;
	esac
 	echo -e "\n"
done

exit
