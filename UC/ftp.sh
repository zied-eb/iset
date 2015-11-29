#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh
clear


MISC_initialize_param $1 $2 $3 $4

list=20

while [ $list -gt 3 ]
do
	echo -e "Please select which BI test to execute : \n"
	echo "1. FT_CWS_WLAN_STA_FNC_FTP_24_BGN"
	echo "2. FT_CWS_WLAN_STA_PERF_ROB_2G4_N_CNX"
	echo "3. Return to the main use case list"
	echo "0. Quit"


	read list
	if [ $list -gt 3  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $list in
	1) ../TCD/Reference/ftp_ref.sh basic $verb $dut1 $locat $time ;;
	2) echo -e "FT_CWS_WLAN_STA_PERF_ROB_2G4_N_CNX \n Not implemented yet" ;;
	3) ../Marvin.sh $verb $dut1 $locat $time ;;
	0) exit ;;
esac
