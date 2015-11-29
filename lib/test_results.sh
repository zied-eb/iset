#! /bin/bash

# Confirm that Wifi is well activated
function TR_check_wifi_on ()
{
	sleep 4

	adb -s $dut1 shell busybox ifconfig | grep ^wlan0
	if [ $? -eq 0 ]
	then
		echo "Wifi is turned ON successfully"
	else

		echo -e " ${red} Test fail at step1: Turn Wifi ON ${noc} "
		MISC_generate_report_failed_result
		MISC_wait_press_key
		if [ $# -eq 1 ]
		then
			$locat/UC/ON_OFF.sh $verb $dut1 $locat $time && exit
		else
			$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time && exit
		fi
		exit
	fi
	sleep 2
}

# Verify that Wifi is well deactivated
function TR_check_wifi_off ()
{
	sleep 2

	adb -s $dut1 shell busybox ifconfig | grep ^wlan0 
	if [ $? -ne 0 ]
	then
		echo "Wifi is turned OFF successfully"
	else
		echo -e " ${red} Test fail at step2: Turn Wifi OFF ${noc} "
		MISC_generate_report_failed_result
		MISC_wait_press_key
		if [ $# -eq 1 ]
		then
			$locat/UC/ON_OFF.sh $verb $dut1 $locat $time && exit
		else
			$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time && exit
		fi
		exit
	fi
	sleep 4
}

# Verify DUT connection to selected network, but still need confirmation by a successful ping
function TR_check_connection ()
{
	wifistatus=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 status | grep "ip_address" | wc -l`
	if [ $wifistatus -gt 0 ]
	then
		echo -e "\nOK, DUT looks connected! Let's try a ping .."
	else
		echo -e "${red} Test fail at Connection process ${noc}"
		MISC_generate_report_failed_result
		MISC_wait_press_key
		$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time && exit
	fi
}

# Verify FAILED connection to selected network
function TR_check_wrong_connection ()
{
	wifistatus=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 status | grep "ip_address" | wc -l`
	if [ $wifistatus -eq 0 ]
	then
		echo "OK, connection not established !"
	else
		echo -e "${red} Test fail at Connection process ${noc}"
		MISC_generate_report_failed_result
		MISC_wait_press_key
		$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time && exit
		exit
	fi
}

# Double check PASSED connection by a ping to the access point
function TR_ping_results ()
{
	if [ $val -eq 1 ]
	then
		echo "Ping successful !"
	else
		echo -e "${red} Test fail at step4: Ping AP from DUT ${noc} "
		MISC_generate_report_failed_result
		MISC_wait_press_key
		$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time && exit
		exit
	fi
}

