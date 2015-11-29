#! /bin/bash

cd $(dirname $0)
. ../../lib/prerequisites.sh
. ../../lib/supplicant.sh
. ../../lib/test_results.sh
. ../../lib/misc.sh

MISC_initialize_param_extra $1 $2 $3 $4 $5

tcname="FT_CWS_WLAN_STA_NEG_FNC_CNX_"$param"_WRNG_PASSWD"

MISC_get_colors
clear
#################################################################
# 			Prerequisites				#
#################################################################

clear
echo -e "Please make sure to set your Access Point with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = $param \n"

echo -e "- <80211_PROTO> = 802.11bgn (mixed) \n"

MISC_wait_press_key

## DUT connection
clear
echo "Checking DUT connection to PC .."

PRE_check_device


## Confirm that wifi is off and no remembered networks
echo "Removing remembered wifi networks.."
PRE_remove_remembered_networks


## Turn OFF Wifi
PRE_wifi_off
TR_check_wifi_off


## Checking wpa_supplicant.conf existance..
echo "Checking wpa_supplicant.conf existance .."
PRE_check_sup_conf_file


clear
echo -e "Test execution ...\n"
sleep 1

#################################################################
#			PROCEDURE				#	
#1- Turn Wifi STA on						#	
#2- From UI try to connect to AP1 SSID using an incorrect 	#
# WPA2 passphrase (different than the one set on the AP)	#
#################################################################

#################
# Test step 1	#
#################

echo "1. Turn Wifi ON"
SUPP_wifi_on

## check results
TR_check_wifi_on

#################
# Test step 2	#
#################

SUPP_scan_process

if [[ $param = "WEP"* ]]
then
	mgmt="NONE"	
else 
	mgmt="WPA-PSK"	
fi

echo "OK, please enter a wrong password for this network"
read pswd

SUPP_define_encryption
SUPP_connect_network

# Verify connection
TR_check_wrong_connection


#################################################################
# 				Results				#
#################################################################


MISC_test_complete_pass

MISC_generate_report

MISC_wait_press_key

$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time
