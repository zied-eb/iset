#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear

MISC_initialize_param $1 $2 $3 $4

list=20
while [ $list -gt 8 ]
do
	echo -e "Please select which BAND test to execute : \n"
	echo "1. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_B_BAND"
	echo "2. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_BG_BAND"
	echo "3. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_G_BAND"
	echo "4. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_BGN_BAND"
	echo "5. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_GN_BAND"
	echo "6. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_N_BAND"
	echo "7. Return to TCD list"
	echo "8. Return to the main use case list"
	echo "0. Quit"


	read list
	if [ $list -gt 8  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $list in
	0) exit ;;
	1) ./band_ref.sh $verb $dut1 $locat $time B ;;
	2) ./band_ref.sh $verb $dut1 $locat $time BG ;;
	3) ./band_ref.sh $verb $dut1 $locat $time G ;;
	4) ./band_ref.sh $verb $dut1 $locat $time BGN ;;
	5) ./band_ref.sh $verb $dut1 $locat $time GN ;;
	6) ./band_ref.sh $verb $dut1 $locat $time N ;;
	7) ../UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	8) ../Marvin.sh $verb $dut1 $locat $time ;;
	*) exit ;;
esac

exit
