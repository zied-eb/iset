#! /bin/bash

cd $(dirname $0)
clear

. ../lib/prerequisites.sh
. ../lib/supplicant.sh
. ../lib/test_results.sh
. ../lib/misc.sh

#########################################################
# 			Prerequisites			#
#########################################################

PRE_get_colors
clear
echo -e "Please make sure to set your Access Point with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = WPA2 \n"

echo -e "- DHCP server running on its LAN side \n"

echo -e "- WPS PIN method is allowed from access point UI \n"

sleep 1

echo -e "\nPress any key to continue.. \n"

read -n1 x
dut1=$1
locat=$2

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
sleep 1


#################################################################################
#				PROCEDURE					#
# 1- On DUT, turn Wifi STA on							#
# 2- Get AP1 WPS PIN code set (from GUI or sticker, it depends on the device)	#
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

echo "2. start WPS PIN method"
SUPP_get_bccid_ap
SUPP_get_pin_ap

#################
# Test step3	#
#################

SUPP_connect_wps_enroll
TR_check_connection

#################
# Test step4	#
#################

# We will try to ping AP instead of using another connected devicd "DEV"
## Ask for IP of access point  from user
read -p "Please provide access point IP : " ipaddress
SUPP_ping_process

TR_ping_results


#################################################################################
#				Results						#
#################################################################################

# If reached this far, so test passed

echo -e "\nFT_CWS_WLAN_STA_FNC_CNX_WPS_PIN_FROM_DUT = ${green} PASS ! ${noc}"

nname=`echo -e "FT_CWS_WLAN_STA_FNC_CNX_WPS_PIN_FROM_DUT"`
passed="PASS"
result=`printf "| %-61s| %-6s\n" $nname $passed`

MISC_generate_report

read -n1 -p "Press any key to return the use case list .." xx
$locat/UC/Config_Wlan.sh $dut1 $locat

