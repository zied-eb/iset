#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear

MISC_initialize_param $1 $2 $3 $4

list=20
while [ $list -gt 5 ]
do
	echo -e "Please select which \"Beacon interval\" test to execute : \n"
	echo "1. FT_CWS_WLAN_STA_FNC_CNX_BEAC_INT_100"
	echo "2. FT_CWS_WLAN_STA_FNC_CNX_BEAC_INT_300"
	echo "3. FT_CWS_WLAN_STA_FNC_CNX_BEAC_INT_500"
	echo "4. Return to TCD list"
	echo "5. Return to the main use case list"
	echo "0. Quit"


	read list
	if [ $list -gt 5  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $list in
	0) exit ;;
	1) ./Reference/beac_ref.sh $verb $dut1 $locat $time 100 ;;
	2) ./Reference/beac_ref.sh $verb $dut1 $locat $time 300 ;;
	3) ./Reference/beac_ref.sh $verb $dut1 $locat $time 500 ;;
	4) ../UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	5) ../Marvin.sh $verb $dut1 $locat $time ;;
esac

exit
