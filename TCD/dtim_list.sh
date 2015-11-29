#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear

MISC_initialize_param $1 $2 $3 $4

dtim=20
while [ $dtim -gt 12 ]
do
	echo -e "Please select which DTIM test to execute : \n"
	echo "1. FT_CWS_WLAN_STA_FNC_CNX_DTIM1"
	echo "2. FT_CWS_WLAN_STA_FNC_CNX_DTIM2"
	echo "3. FT_CWS_WLAN_STA_FNC_CNX_DTIM3"
	echo "4. FT_CWS_WLAN_STA_FNC_CNX_DTIM4"
	echo "5. FT_CWS_WLAN_STA_FNC_CNX_DTIM5"
	echo "6. FT_CWS_WLAN_STA_FNC_CNX_DTIM6"
	echo "7. FT_CWS_WLAN_STA_FNC_CNX_DTIM7"
	echo "8. FT_CWS_WLAN_STA_FNC_CNX_DTIM8"
	echo "9. FT_CWS_WLAN_STA_FNC_CNX_DTIM9"
	echo "10. FT_CWS_WLAN_STA_FNC_CNX_DTIM10"
	echo "11. Return to TCD list"
	echo "12. Return to the main use case list"
	echo "0. Quit"

	read dtim
	if [ $dtim -gt 12  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $dtim in
	0) exit ;;
	1) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 1 ;;
	2) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 2 ;;
	3) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 3 ;;
	4) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 4 ;;
	5) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 5 ;;
	6) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 6 ;;
	7) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 7 ;;
	8) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 8 ;;
	9) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 9 ;;
	10) ./Reference/dtim_ref.sh $verb $dut1 $locat $time 10 ;;
	11) ../UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	12) ../Marvin.sh $verb $dut1 $locat $time ;;
esac
