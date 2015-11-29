#! /bin/bash

cd $(dirname $0)
. ../../lib/prerequisites.sh
. ../../lib/supplicant.sh
. ../../lib/test_results.sh
. ../../lib/misc.sh

MISC_initialize_param_extra $1 $2 $3 $4 $5

tcname="FT_CWS_WLAN_STA_FNC_CNX_DTIM $param"

MISC_get_colors
clear

MISC_verbose_on

#########################################################################
# 				Prerequisites				#
#########################################################################

echo -e "Please make sure to set your Access Point with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = WPA2-AES \n"

echo -e "- <AP Beacon interval> = 100 \n"

echo -e "- <AP DTIM> = $param \n"

MISC_wait_press_key


## DUT connection
clear
echo "Checking DUT connection to PC .."

PRE_check_device > /dev/$sortie


## Confirm that wifi is off and no remembered networks
echo "Removing remembered wifi networks.."
PRE_remove_remembered_networks > /dev/$sortie


## Turn OFF Wifi
echo "Checking wifi status.."
PRE_check_wifi_status > /dev/$sortie


## Checking wpa_supplicant.conf existance..
echo "Checking wpa_supplicant.conf existance .."
PRE_check_sup_conf_file > /dev/$sortie


#########################################################################
#				PROCEDURE				#
#1- Turn Wifi on							#
#2- Set AP DTIM according to TCD					#
#3- After AP reboots, start and check beacons in sniffer trace		#
#4- Check SSID list in WifiSettings Android UI and connect to AP SSID.	#
#5- Ping the DUT from DEV (but in our case, we will ping AP from DUT)	#
#########################################################################

#################
# Test step 1	#
#################

echo "1. Turn Wifi ON"
SUPP_wifi_on > /dev/$sortie

## check results
TR_check_wifi_on > /dev/$sortie

#################
# Test step 2	#
#################
 
## Asking user to set DTIM to required value
echo -e "2. Please set you AP DTIM to $param \n \n "
MISC_wait_press_key

#################
# Test step 3	#
#################

## Let user check fi DTIM is correct using the sniffer
echo -e "Check if DTIM is correct, using a sniffer"
sleep 1

MISC_wait_press_key

#################
# Test step 4	#
#################

## Proceed in the connection process
SUPP_scan_process
SUPP_define_key_mgmt
SUPP_define_encryption > /dev/$sortie
SUPP_connect_network > /dev/$sortie

# Check connection
TR_check_connection

# Ask for the access point IP from user
read -p "Please provide access point IP : " ipaddress


#################
# Test step 5	#
#################
# We will ping AP from DUT instead, to simplify the script (confirmed by Honore)

echo "Ping AP from DUT, please wait .."

SUPP_ping_process > /dev/$sortie
TR_ping_results > /dev/$sortie


#########################################################################
#				Results					#
#########################################################################

MISC_verbose_off

# If reached this far, so test passed

MISC_test_complete_pass

MISC_generate_report

MISC_wait_press_key

$locat/UC/Config_Wlan.sh $verb $dut1 $locat $time

