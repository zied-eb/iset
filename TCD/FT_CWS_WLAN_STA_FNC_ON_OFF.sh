#! /bin/bash


cd $(dirname $0)
. ../lib/prerequisites.sh
. ../lib/supplicant.sh
. ../lib/test_results.sh
. ../lib/misc.sh

MISC_initialize_param $1 $2 $3 $4
tcname="FT_CWS_WLAN_STA_FNC_ON_OFF"

MISC_verbose_on

clear

#########################################################
#		Prerequisites 				#
#- DUT is USB connected to a host PC			#
#- WiFi STA is OFF					#
#- wifi service is running (1)				#
#- No previous /data/misc/wifi/wpa_supplicant.conf 	#
#   file exist (remove it if already exist)		#
#########################################################

MISC_get_colors


# Confirm that wifi is off
echo "Checking wifi status.."
PRE_check_wifi_status > /dev/$sortie

# Confirm wifi service is running
echo "Checking wifi service .."
PRE_check_wifi_service > /dev/$sortie

## Checking wpa_supplicant.conf existance..
echo "Checking wpa_supplicant.conf existance .."
PRE_check_sup_conf_file > /dev/$sortie




clear
echo -e "Test execution ...\n"

#########################################################
#			PROCEDURE			#
#1- Launch "Settings" application and turn Wifi ON	#
#2- Turn Wifi OFF					#
#3- Replay steps "1" and "2"				#
#########################################################


#################
# Test step 1	#
#################
echo "1. Turn Wifi ON"
SUPP_wifi_on > /dev/$sortie

# check results
TR_check_wifi_on 1 > /dev/$sortie


#################
# Test step 2	#
#################
echo "2. Turn Wifi OFF"
SUPP_wifi_off > /dev/$sortie


# check results
TR_check_wifi_off 1 > /dev/$sortie

#################
# Test step 3	#
#################
echo "3. Replay steps 1 and 2"
SUPP_wifi_on > /dev/$sortie
sleep 5

## check if wifi enabled
TR_check_wifi_on 1 > /dev/$sortie

sleep 3
## Turn OFF wifi again and check if it is done
SUPP_wifi_off > /dev/$sortie
TR_check_wifi_off 1 > /dev/$sortie

MISC_verbose_off 

#########################################################
#			Results				#
#########################################################

# If reached this far, then test passed


MISC_test_complete_pass

MISC_generate_report

MISC_wait_press_key

$locat/UC/ON_OFF.sh $verb $dut1 $locat $time


