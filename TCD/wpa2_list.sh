#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh

MISC_initialize_param $1 $2 $3 $4

clear

list=20

while [ $list -gt 7 ]
do
	echo -e "Please select which WPA2 test to execute : \n"
	echo "1. FT_CWS_WLAN_STA_FNC_CNX_WPA2_TKIP"
	echo "2. FT_CWS_WLAN_STA_FNC_CNX_WPA2_AES"
	echo "3. FT_CWS_WLAN_STA_FNC_CNX_WPA2_TKIP_AES"
	echo "4. FT_CWS_WLAN_STA_NEG_FNC_CNX_WPA2_WRNG_PASSWD"
	echo "5. Return to TCD list"
	echo "6. Return to the main use case list"
	echo "0. Quit"


	read list
	if [ $list -gt 7  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $list in
	0) exit ;;
	1) ./wpa2_ref.sh $verb $dut1 $locat $time WPA2_TKIP ;;
	2) ./wpa2_ref.sh $verb $dut1 $locat $time WPA2_AES ;;
	3) ./wpa2_ref.sh $verb $dut1 $locat $time WPA2_TKIP_AES ;;
	4) ./Reference/wrong_key.sh $verb $dut1 $locat $time WPA2 ;;
	5) ../UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	6) ../Marvin.sh $verb $dut1 $locat $time ;;
	*) exit ;;
esac	
