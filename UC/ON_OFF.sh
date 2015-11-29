#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear

MISC_initialize_param $1 $2 $3 $4


TCD=10
while [ $TCD -gt 2 ]
do
	clear
	echo -e "This use case contains only one TCD:\n"
	echo "1. FT_CWS_WLAN_STA_FNC_ON_OFF"
	echo "2. Return to the main use case list"
	echo "0. Quit"
	echo -e "\n Please select an option : "
	read TCD

	if [ $TCD -gt 2 ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $TCD in
	1) ../TCD/FT_CWS_WLAN_STA_FNC_ON_OFF.sh $verb $dut1 $locat $time ;;
	2) ../Marvin.sh $verb $dut1 $locat $time ;;
	0) exit ;;
esac

