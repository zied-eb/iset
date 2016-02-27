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
#echo "Checking wifi status.."
#sleep 1
#PRE_check_wifi_status > /dev/$sortie

# Confirm wifi service is running
# echo "Checking wifi service .."
# sleep 1
#PRE_check_wifi_service > /dev/$sortie

## Checking wpa_supplicant.conf existance..
# echo "Checking wpa_supplicant.conf existance .."
# sleep 1
#PRE_check_sup_conf_file > /dev/$sortie


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
#			PROCEDURE			#
#1- Launch "Settings" application and turn Wifi ON	#
#2- Turn Wifi OFF					#
#3- Replay steps "1" and "2"				#
#########################################################


#################
# Test step 1	#
#################
echo "1. Turn Wifi ON then OFF ..."

if [ $verb -gt 1 ] 
then
	(
	echo "10" ; sleep 1
	echo "# Checking wifi status.." ; sleep 1
	echo "20" ; sleep 1
	echo "# Checking wifi service .." ; sleep 1
	echo "30" ; sleep 1
	echo "# Checking wpa_supplicant.conf existance .." ; sleep 1
	echo "40" ; sleep 1
	echo "# Turning Wi-Fi ON" ; sleep 1
	echo "50" ; sleep 1; echo "60" ; sleep 1 ; echo "70" ; sleep 1; echo "# OK, now.." ; sleep 1 ; echo "79"
	echo "# Turning Wi-Fi OFF" ; sleep 1
	echo "80" ; sleep 1; echo "90" ; sleep 1 ; echo "100" ; sleep 1
	) |
	zenity --progress \
	--title="Enable / disable Wi-Fi radio" \
	--text="Prepare for Wi-Fi management..." \
	--auto-close \
	--percentage=0
else
	echo "Wait, test execution in progress"
	sleep 2
fi

#SUPP_wifi_on > /dev/$sortie


# check results
#TR_check_wifi_on 1 > /dev/$sortie



#################
# Test step 2	#
#################
#echo "2. Turn Wifi OFF"
#SUPP_wifi_off > /dev/$sortie


# check results
#TR_check_wifi_off 1 > /dev/$sortie

#################
# Test step 3	#
#################
# echo "3. Replay steps 1 and 2"
# SUPP_wifi_on > /dev/$sortie
# sleep 5
# 
# ## check if wifi enabled
# TR_check_wifi_on 1 > /dev/$sortie
# 
# sleep 3
# ## Turn OFF wifi again and check if it is done
# SUPP_wifi_off > /dev/$sortie
# TR_check_wifi_off 1 > /dev/$sortie

MISC_verbose_off 

#########################################################
#			Results				#
#########################################################

# If reached this far, then test passed

if [ $result = "pass" ] 
then 
	MISC_test_complete_pass
	MISC_generate_report
else
	MISC_test_complete_fail
	MISC_generate_report_failed_result
fi

MISC_wait_press_key

$locat/UC/ON_OFF.sh $verb $dut1 $locat $time


