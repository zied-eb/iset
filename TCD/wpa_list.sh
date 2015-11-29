#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh

MISC_initialize_param $1 $2 $3 $4

clear

list=20
while [ $list -gt 5 ]
do
	echo -e "Please select which WPA2 test to execute : \n"
	echo "1. FT_CWS_WLAN_STA_FNC_CNX_WPA_TKIP"
	echo "2. FT_CWS_WLAN_STA_FNC_CNX_WPA_AES"
	echo "3. FT_CWS_WLAN_STA_NEG_FNC_CNX_WPA_WRNG_PASSWD"
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
	1) ./wpa_ref.sh $verb $dut1 $locat $time WPA_TKIP ;;
	2) ./wpa_ref.sh $verb $dut1 $locat $time WPA_AES ;;
	3) ./Reference/wrong_key.sh $verb $dut1 $locat $time WPA ;;
	5) ../UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	6) ../Marvin.sh $verb $dut1 $locat $time ;;
	*) exit ;;
esac	

