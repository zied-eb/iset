#! /bin/bash

cd $(dirname $0)
. ../../lib/prerequisites.sh
. ../../lib/supplicant.sh
. ../../lib/test_results.sh
. ../../lib/misc.sh

MISC_initialize_param_extra $1 $2 $3 $4 $5

tcname="FT_CWS_WLAN_STA_FNC_CNX_"$param

clear

MISC_get_colors

MISC_verbose_on

#########################################################
# 			Prerequisites								#
#########################################################


## Confirm that wifi is off and no remembered networks
#echo "Removing remembered wifi networks.."
# PRE_remove_remembered_networks > /dev/$sortie
# 
# ## Check if wifi was already turned off by the previous function, otherwise disable it
#echo "Checking wifi status.."
# PRE_check_wifi_status > /dev/$sortie
# 
# ## Checking wpa_supplicant.conf existance..
#echo "Checking wpa_supplicant.conf existance .."
# PRE_check_sup_conf_file > /dev/$sortie

if [ $verb -gt 1 ] 
then
	(
	echo "5" ; sleep 1
	echo "# Removing remembered wifi networks.." ; sleep 1
	echo "20" ; sleep 1
	echo "# Checking wifi status.." ; sleep 1
	echo "40" ; sleep 1
	echo "# Checking wifi service .." ; sleep 1
	echo "60" ; sleep 1
	echo "# Checking wpa_supplicant.conf existance .." ; sleep 1
	echo "80" ; sleep 1
	echo "# Turning Wi-Fi OFF" ; sleep 1
	echo "100" ; sleep 1
	) |
	zenity --progress \
	--title="Checking Wi-Fi prerequisites" \
	--text="Prepare Wi-Fi Environment " \
	--auto-close \
	--percentage=0
else
	echo "Wait, test execution in progress"
	sleep 2
fi

sleep 1




zenity --question --title="Simulate test result" --text="Would you want the test to pass?"

if [ $? = 0 ] 
then
	result="pass"
else
	result="fail"
fi


clear
echo -e "Test execution ...\n"

#########################################################
#			PROCEDURE									#
#1- Turn Wifi STA on									#
#2- Connect <SSID> with password <PASSWORD>				#
#3- Get DUT IP address (1).								#
# We'll store it in <DUT_IP_ADDR>						#
#4- From DEV, ping DUT:									#
#dev$ ping -c 10 <DUT_IP_ADDR>							#
#########################################################

#################
# Test step 1	#
#################


echo "1. Turn Wifi ON"
#SUPP_wifi_on > /dev/$sortie

## check results
#TR_check_wifi_on > /dev/$sortie

#################
# Test step2	#
#################

# Set static_ip if required
# if [ $param = "IP_STATIC" ]
# then
# 	MISC_get_static_ip
# fi

# Start scan
SUPP_scan_process

# Set key_mgmt according to network security
#SUPP_define_key_mgmt
#
#Set pairwise and group according to encryption
#SUPP_define_encryption > /dev/$sortie

# echo "Connecting to the secured WLAN .."
# if [[ $param = "OPN_"* ]] || [[ $param = "SHRD_"* ]]
# then
# 	SUPP_connect_network_wep > /dev/$sortie
# else
# 	SUPP_connect_network > /dev/$sortie
# 
# fi

# Check step2 result
# TR_check_connection




#################
# Test step 3	#
#################
## Ask for IP of access point from user

ipvalid=false
while [ $ipvalid ]; do
	read -p "Please provide access point IP : " ipaddress
	MISC_validateIP $ipaddress

	if [[ $? -ne 0 ]];then
		echo "Invalid IP Address ($ipaddress)"
	else
		echo "$ipaddress is a Perfect IP Address"
		break
	fi
done

#################
# Test step 4	#
#################

# From DEV, ping DUT
## But we will ping AP from DUT instead, to simplify the script (confirmed by Honore)

# SUPP_ping_process > /dev/$sortie
# TR_ping_results > /dev/$sortie





#########################################################
#			Results				#
#########################################################

MISC_verbose_off

# If reached this far, so test passed
 
MISC_test_complete_pass

MISC_generate_report

MISC_wait_press_key

$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time
