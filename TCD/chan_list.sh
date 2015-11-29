#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear

MISC_initialize_param $1 $2 $3 $4

chan=20
while [ $chan -gt 16 ]
do
	echo -e "Please select which Channel test to execute : \n"


	echo "1. FT_CWS_WLAN_STA_FNC_CNX_Channel1"
	echo "2. FT_CWS_WLAN_STA_FNC_CNX_Channel2"
	echo "3. FT_CWS_WLAN_STA_FNC_CNX_Channel3"
	echo "4. FT_CWS_WLAN_STA_FNC_CNX_Channel4"
	echo "5. FT_CWS_WLAN_STA_FNC_CNX_Channel5"
	echo "6. FT_CWS_WLAN_STA_FNC_CNX_Channel6"
	echo "7. FT_CWS_WLAN_STA_FNC_CNX_Channel7"
	echo "8. FT_CWS_WLAN_STA_FNC_CNX_Channel8"
	echo "9. FT_CWS_WLAN_STA_FNC_CNX_Channel9"
	echo "10. FT_CWS_WLAN_STA_FNC_CNX_Channel10"
	echo "11. FT_CWS_WLAN_STA_FNC_CNX_Channel11"
	echo "12. FT_CWS_WLAN_STA_FNC_CNX_Channel12"
	echo "13. FT_CWS_WLAN_STA_FNC_CNX_Channel13"
	echo "14. FT_CWS_WLAN_STA_FNC_CNX_Channel14"
	echo "15. Return to TCD list"
	echo "16. Return to the main use case list"
	echo "0. Quit"

	read chan
	if [ $chan -gt 16  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
	
done

case $chan in
	0) exit ;;
	1) ./chan_ref.sh $verb $dut1 $locat $time 1 ;;
	2) ./chan_ref.sh $verb $dut1 $locat $time 2 ;;
	3) ./chan_ref.sh $verb $dut1 $locat $time 3 ;;
	4) ./chan_ref.sh $verb $dut1 $locat $time 4 ;;
	5) ./chan_ref.sh $verb $dut1 $locat $time 5 ;;
	6) ./chan_ref.sh $verb $dut1 $locat $time 6 ;;
	7) ./chan_ref.sh $verb $dut1 $locat $time 7 ;;
	8) ./chan_ref.sh $verb $dut1 $locat $time 8 ;;
	9) ./chan_ref.sh $verb $dut1 $locat $time 9 ;;
	10) ./chan_ref.sh $verb $dut1 $locat $time 10 ;;
	11) ./chan_ref.sh $verb $dut1 $locat $time 11 ;;
	12) ./chan_ref.sh $verb $dut1 $locat $time 12 ;;
	13) ./chan_ref.sh $verb $dut1 $locat $time 13 ;;
	14) ./chan_ref.sh $verb $dut1 $locat $time 14 ;;
	15) ../UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	16) ../Marvin.sh $verb $dut1 $locat $time ;;
esac

exit
