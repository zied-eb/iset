#! /bin/bash

cd $(dirname $0)
clear

. ../lib/prerequisites.sh
. ../lib/supplicant.sh
. ../lib/test_results.sh
. ../lib/misc.sh

MISC_initialize_param $1 $2 $3 $4

tcname="FT_CWS_WLAN_STA_FNC_CNX_WPS_PIN_FROM_DUT"

#########################################################
# 			Prerequisites			#
#########################################################
MISC_get_colors

clear
echo -e "Please make sure to set your Access Point with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = WPA2 \n"

echo -e "- DHCP server running on its LAN side \n"

echo -e "- WPS PIN method is allowed from access point UI \n"

MISC_wait_press_key


## Confirm that wifi is off and no remembered networks
echo "Removing remembered wifi networks.."
PRE_remove_remembered_networks

## Check if wifi was already turned off by the previous function, otherwise disable it
PRE_check_wifi_status

## Checking wpa_supplicant.conf existance..
echo "Checking wpa_supplicant.conf existance .."
PRE_check_sup_conf_file


clear
echo -e "Test execution ...\n"


#################################################################################
#				PROCEDURE					#
# 1- On DUT, turn Wifi STA on							#
# 2- On DUT, start WPS PIN method (1) and obtain the PIN code generated.	#
# We'll store it in <PIN>							#
# 3- 30 sec max after issuing step2, on AP UI, register the DUT WPS PIN <PIN>	#
# 4- Get DUT IP address (4)							#
# Wel'll store it in <DUT_IP_ADDR>						#
# 5- From DEV, ping DUT:							#
# dev$ ping -c 20 <DUT_IP_ADDR>							#
#################################################################################

#################
# Test step 1	#
#################

echo "1. Turn Wifi ON"
SUPP_wifi_on

## check results
TR_check_wifi_on

#################
# Test step2	#
#################

SUPP_wps_pin
echo -e "In 30 seconds max, enter the following PIN : ${blue} $wpin ${noc}   \n" 

#################
# Test step3	#
#################

SUPP_wps_pin_resume
TR_check_connection

if [ "$passed" == "FAIL" ]
then
	exit
fi

#################
# Test step4	#
#################

# We will try to ping AP instead of using another connected device "DEV"
## Ask for IP of access point  from user
read -p "Please provide access point IP : " ipaddress
SUPP_ping_process

TR_ping_results

if [ "$passed" == "FAIL" ]
then
	exit
fi

#################################################################################
#				Results						#
#################################################################################

# If reached this far, so test passed

MISC_test_complete_pass

MISC_generate_report

MISC_wait_press_key

$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time

