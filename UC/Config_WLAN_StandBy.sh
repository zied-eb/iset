#! /bin/bash

cd $(dirname $0)
clear

TCD=100
dut1=$1
locat=$2
time=$3

while [ $TCD -gt 12 ]
do
	clear
	echo -e "Please choose a TCD to run from the list : \n"

	echo "1. FT_CWS_WLAN_STA_FNC_FILTERING_UNICAST_ALLOW"
	echo "2. FT_CWS_WLAN_STA_FNC_FILTERING_BROADCAST_FILTER"
	echo "3. FT_CWS_WLAN_STA_FNC_FILTERING_IPV4_MULTICAST2UNICAST_FILTER"
	echo "4. FT_CWS_WLAN_STA_FNC_FILTERING_IPV6_MULTICAST2UNICAST_FILTER"
	echo "5. FT_CWS_WLAN_STA_FNC_FILTERING_MULTICAST_IPV4_ALLOW"
	echo "6. FT_CWS_WLAN_STA_FNC_FILTERING_MULTICAST_IPv6_ALLOW"
	echo "7. FT_CWS_WLAN_STA_FNC_FILTERING_MULTICAST_IPV4_FILTER"
	echo "8. FT_CWS_WLAN_STA_FNC_FILTERING_MULTICAST_IPV6_FILTER"
	echo "9. FT_CWS_WLAN_STA_FNC_FILTERING_MULTICAST_IPv4_MDNS_FILTER"
	echo "10. FT_CWS_WLAN_STA_FNC_FILTERING_MULTICAST_IPv6_MDNS_FILTER"
	echo "11. FT_CWS_WLAN_STA_FNC_FILTERING_UPNP"
	echo "12. Return to the main use case list"
	echo "0. Quit"

	read TCD
	if [ $TCD -gt 12  ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
done

case $TCD in
	1) ../TCD/filter_list.sh $dut1 $locat $time ;;
	2) ../TCD/filter_list.sh $dut1 $locat $time ;;
	3) ../TCD/filter_list.sh $dut1 $locat $time ;;
	4) ../TCD/filter_list.sh $dut1 $locat $time ;;
	5) ../TCD/filter_list.sh $dut1 $locat $time ;;
	6) ../TCD/filter_list.sh $dut1 $locat $time ;;
	7) ../TCD/filter_list.sh $dut1 $locat $time ;;
	8) ../TCD/filter_list.sh $dut1 $locat $time ;;
	9) ../TCD/filter_list.sh $dut1 $locat $time ;;
	10) ../TCD/filter_list.sh $dut1 $locat $time ;;
	11) ../TCD/filter_list.sh $dut1 $locat $time ;;
	12) ../Marvin.sh $dut1 $locat $time 1 ;;
	0) exit ;;
	
esac

