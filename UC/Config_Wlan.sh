#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear

MISC_get_colors
MISC_initialize_param $1 $2 $3 $4

TCD=20

while [ $TCD -gt 15 ]
do
	clear
	echo -e "Please choose a TCD to run from the list : \n"

	echo -e "1. FT_CWS_WLAN_STA_FNC_CNX_AP_2G4_ < ${blue} B/G/N/BG/GN/BGN ${noc} > _BAND"
	echo -e "2. FT_CWS_WLAN_STA_FNC_CNX_BEAC_INT_ < ${blue} 100/300/500 ${noc} >"
	echo -e "3. FT_CWS_WLAN_STA_FNC_CNX_Channel < ${blue} 1-14 ${noc} >"
	echo -e "4. FT_CWS_WLAN_STA_FNC_CNX_DTIM < ${blue} 1-10 ${noc} >"
	echo "5. FT_CWS_WLAN_STA_FNC_SCAN_DUPL_SSID_DIFF_SEC"
	echo "6. FT_CWS_WLAN_STA_FNC_SCAN_DUPL_SSID_DUPL_SEC"
	echo -e "7. FT_CWS_WLAN_STA_FNC_CNX_WPA2 < ${blue} TKIP-AES-WRGPSWD ${noc} >"
	echo -e "8. FT_CWS_WLAN_STA_FNC_CNX_WPA_ < ${blue} TKIP-AES-WRGPSWD ${noc} >"
	echo "9. FT_CWS_WLAN_STA_FNC_CNX_OPN"
	echo -e "10. FT_CWS_WLAN_STA_FNC_CNX_OPN_WEP < ${blue} OPN/SHRD_WEP64/128_WRNG_PSSWD ${noc} > "
	echo "11. FT_CWS_WLAN_STA_FNC_CNX_WPS_PIN_FROM_DUT"
	echo "12. FT_CWS_WLAN_STA_FNC_CNX_WPS_PIN_ENROLL"
	echo "13. FT_CWS_WLAN_STA_NEG_FNC_CNX_WPS_PIN_WRNG_PIN"
	echo "14. FT_CWS_WLAN_STA_FNC_CNX_IP_STATIC"
	echo "15. Return to the main use case list"
	echo "0. Quit"

	read TCD

	if [ $TCD -gt 15  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $TCD in
	1) ../TCD/band_list.sh $verb $dut1 $locat $time ;;
	2) ../TCD/beac_list.sh $verb $dut1 $locat $time ;;
	3) ../TCD/chan_list.sh $verb $dut1 $locat $time ;;
	4) ../TCD/dtim_list.sh $verb $dut1 $locat $time ;;
	5) echo "Not implemented yet" ;;
	6) echo "Not implemented yet" ;;
	7) ../TCD/wpa2_list.sh $verb $dut1 $locat $time ;;
	8) ../TCD/wpa_list.sh $verb $dut1 $locat $time ;;
	9) ../TCD/open.sh $verb $dut1 $locat $time ;;
	10) ../TCD/wep_list.sh $verb $dut1 $locat $time ;;
	11) ../TCD/wps_pin_from_dut.sh $verb $dut1 $locat $time ;; 
	12) echo "Aborted - will not be implemented" ;;
	13) echo "Aborted - will not be implemented" ;;
	14) ../TCD/ip_static.sh $verb $dut1 $locat $time ;;
	15) ../Marvin.sh $verb $dut1 $locat $time ;;
	0) exit ;;
esac

exit

