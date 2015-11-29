#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh

MISC_initialize_param_extra $1 $2 $3 $4 $5

../UC/Config_Wlan.sh $verb $dut1 $locat $time

#MISC_initialize_param $1 $2 $3 $4
#list=20

#while [ $list -gt 8 ]
#do
#	echo -e "Please select which filter test to execute : \n"

#	echo "1. FT_CWS_WLAN_STA_FNC_CNX_OPN_WEP64"
#	echo "2. FT_CWS_WLAN_STA_FNC_CNX_OPN_WEP128"
#	echo "3. FT_CWS_WLAN_STA_FNC_CNX_SHRD_WEP64"
#	echo "4. FT_CWS_WLAN_STA_FNC_CNX_SHRD_WEP128"
#	echo "5. FT_CWS_WLAN_STA_NEG_FNC_CNX_WEP64_WRNG_PSSWD"
#	echo "6. FT_CWS_WLAN_STA_NEG_FNC_CNX_WEP128_WRNG_PSSWD"
#	echo "7. Return to TCD list"
#	echo "8. Return to the main use case list"
#	echo "0. Quit"


#	read list
#	if [ $list -gt 8  ]
#	then
#		echo "Wrong choice !"
#		sleep 1
#	fi
#done

#case $list in
#	0) exit ;;
#	1) ./Reference/FT_CWS_WLAN_STA_FNC_FILTERING___REF.sh OPN_WEP64 $dut1 $2 $3 ;;
#	2) ./Reference/FT_CWS_WLAN_STA_FNC_FILTERING___REF.sh OPN_WEP128 $dut1 $2 $3 ;;
#	3) ./Reference/FT_CWS_WLAN_STA_FNC_FILTERING___REF.sh SHRD_WEP64 $dut1 $2 $3 ;;
#	4) ./Reference/FT_CWS_WLAN_STA_FNC_FILTERING___REF.sh SHRD_WEP128 $dut1 $2 $3 ;;
#	5) echo "TBD" ;;
#	6) echo "TBD" ;;
#	7) ../UC/Config_Wlan.sh $dut1 $2 $3 ;;
#	8) ../Marvin.sh $dut1 $2 $3 1 ;;
#esac	
