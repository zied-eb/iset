#! /bin/bash

# Turn Wifi OFF
function SUPP_wifi_off ()
{
	adb -s $dut1 shell svc wifi disable
	sleep 1	
}
# Turn Wifi ON
function SUPP_wifi_on ()
{
	adb -s $dut1 shell svc wifi enable
	sleep 2
}

# Scan for available Wifi network, and let user select one of them
function SUPP_scan_process ()
{
	loopscan=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 scan | grep OK`
	echo -e "Scaning ...\n"
	sleep 1
	i=0
	while [ $? -ne 0 ] && [ $i -lt 3 ]
	do
		sleep 1
		((i++))
		loopscan=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 scan | grep OK`
	done

	
	scanning=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 scan_results | cut -f5 | tail -n +3`
	nb=`echo "$scanning" | wc -l`	

	PS3='Please select a WLAN network from the following list : '
	select ssid in $scanning
	do
		if [ $REPLY -gt 0 ] && [ $REPLY -le $nb ]
		then
			echo -e "\n You have selected : " $ssid
			break
		else
			echo "Bad choice !"
		fi
	done
	ssid=`echo $ssid | tr -d '\r'`
}

# Provide which type of security is needed each test to execute (between open, wep and WPA/WPA2)
function SUPP_define_key_mgmt ()
{
	if [ $param = "OPN" ]
	then
		mgmt="NONE"
	elif [[ $param = "OPN_"* ]] || [[ $param = "SHRD_"* ]]
	then
		mgmt="NONE"
		echo "OK, please enter the wep-key for this network"
		read -p "Password : " pswd
		longch=`echo $pswd | wc -m`	
		while [ $longch -ne 11 ] && [ $longch -ne 27 ]
		do
			echo "Wep-key should have either 10 chars (64bit) or 26 chars (128bit)"
			read -p "Password : " pswd
			longch=`echo $pswd | wc -m`
		done
		
	else
		mgmt="WPA-PSK"	
		echo -e "\vOK, please enter the password for this network"
		read -p "Password : " pswd
		longch=`echo $pswd | wc -m`	
		while [ $longch -lt 9 ]
		do

			echo "Password should at least have 8 characters"
			read -p "Password : " pswd
			longch=`echo $pswd | wc -m`
		done
	fi
	echo -e "\v"

}

# Provide encryption value needed for connection
function SUPP_define_encryption ()
{
	if [ $param = "WPA2_TKIP" ] || [ $param = "WPA_TKIP" ]
	then
		pg="TKIP"
	elif [ $param = "WPA2_AES" ] || [ $param = "WPA_AES" ]
	then
		pg="CCMP"
	else
		pg="CCMP TKIP"
	fi
}

# Connection process via wpa_cli (customized for each security/encryption)
function SUPP_connect_network ()
{

	adb -s $dut1 shell wpa_cli IFNAME=wlan0 add_network
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 auth_alg OPEN
	if [ $param != "OPN" ]
	then
		adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 key_mgmt $mgmt
		adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 psk \"$pswd\"
		adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 pairwise $pg
		adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 group $pg
	fi
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 mode 0
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 ssid \"$ssid\"
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 select_network 0
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 enable_network 0
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 reassociate
	echo "Waiting for connection to be established ..."
	sleep 10


}

# Connection process via wpa_cli for WEP security
function SUPP_connect_network_wep ()
{
	if [[ $param = "SHRD"* ]]
	then
		opn="SHARED"
	else
		opn="OPEN"
	fi

	adb -s $dut1 shell wpa_cli IFNAME=wlan0 add_network
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 auth_alg $opn
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 wep_key0 $pswd
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 key_mgmt $mgmt
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 mode 0
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 set_network 0 ssid \"$ssid\"
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 select_network 0
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 enable_network 0
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 reassociate
	echo "Waiting for connection to be established ..."
	sleep 10
}

# Ping process for access point (IP address already provided by user)
function SUPP_ping_process ()
{
	echo "Ping AP from DUT, please wait .."

	testping=$(adb -s $dut1 shell ping -c 10 $ipaddress)
	echo -e "\n $testping \n "
	val=`echo $testping | grep "10 received" | wc -l`
}

# Prompt user to set access point with WPS-PIN method
function SUPP_wps_pin ()
{
	wpin=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 wps_pin any | tail -1`
	echo "Please set your access point to connect through WPS-PIN method"
}

# After user intervention on access point, this function will resume the WPS-PIN connection process
function SUPP_wps_pin_resume()
{
	sleep 3
	read -n1 -t30 -p "Then, press any key to continue.." xx
	echo -e " \n "
	if [ $? -ne 0 ]
	then
		echo "Sorry, but you have exceeded 30 seconds !!"
		MISC_wait_press_key

		 $locat/UC/Config_Wlan.sh $verb $dut1 $locat $time && exit
	fi
	sleep 10
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 select_network 0
	sleep 2
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 enable_network 0
	sleep 2
	read -n1 -t20 -p "Wait for confirmation from AP, then press any key to continue.." xx
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 reassociate

	echo "Waiting for connection to be established ..."
	sleep 10
}

# Function needto for PIN_ENROLL test (this test is aborted)
function SUPP_get_bccid_ap ()
{
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 scan
	sleep 2
	list=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 scan_results`
	echo "Here is the list of available AP with WPS enabled, Please select (copy/paste) its bssid"
	echo -e "$list" | cut -f1,4,5 | grep "WPS" | cut -f1,3
	read -p "BSSID : " bssid
}

# Function needto for PIN_ENROLL test (this test is aborted)
function SUPP_get_pin_ap ()
{
	echo "Please provide the PIN of access point (from GUI or sticker)"
	read ap_pin
	pinlong=`echo $ap_pin | wc -m`
	while [ $pinlong -ne 9 ]
	do
		read -p "PIN should have 8 digits : " ap_pin
		pinlong=`echo $ap_pin | wc -m`
	done
}

# Function needto for PIN_ENROLL test (this test is aborted)
function SUPP_connect_wps_enroll ()
{
	adb -s $dut1 shell busybox ifconfig wlan0 up
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 wps_reg $bssid \"$ap_pin\"
	sleep 30
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 status
	sleep 1
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 select_network 0
	sleep 2
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 enable_network 0
	sleep 2
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 reassociate

	echo "Waiting for connection to be established ..."
	sleep 5
}

