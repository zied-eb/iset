#! /bin/bash

param=$1
dut1=$2

cd $(dirname $0)
. ../../lib/prerequisites.sh
. ../../lib/supplicant.sh
. ../../lib/test_results.sh
. ../../lib/misc.sh


MISC_get_colors
clear

#########################################################################
# 				Prerequisites				#
#########################################################################


echo -e "Please prepare your environment with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = WPA2-AES \n"

echo -e "- <80211_MODE>: 802.11bgn \n"

echo -e "Server should have: \n "
echo -e "- <FILE_SIZE>: 50MB \n"

#echo -e "The <LOOP_COUNT> is 10 \n"

sleep 1

echo -e "\nPress any key to continue.. \n"

read -n1 x

FILE_SIZE=50
LOOP_COUNT=10



## Confirm that wifi is off and no remembered networks
echo "Removing remembered wifi networks.."
PRE_remove_remembered_networks


## Turn OFF Wifi
PRE_check_wifi_status


## Checking wpa_supplicant.conf existance..
echo "Checking wpa_supplicant.conf existance .."
PRE_check_sup_conf_file




#################################################################################################################
# 							PROCEDURE						#
#1- Turn on wifi												#
#2- Connect <SSID> providing <PASSWORD>, then get back to home screen						#
#3- From LAPTOP, monitor wifi events in order to check there is no disconnection during FTP transfert		#
#laptop$ adb shell iw event -t -f										#
#4- From DUT (using adb shell), perform FTP download <LOOP_COUNT> times:					#
#laptop$ adb shell												#
#dut$ cd /data													#
#dut$ x=1; while [ $x -le <LOOP_COUNT> ]; 									#
#do ftpget -u ftptest -p ftppassword <FTP_SRV_IP_ADDR> file_test.bin file_test.bin; 				#
#ls -l file_test.bin; rm file_test.bin; x=$(( $x + 1 )); sleep 2; done						#
#5- From DUT (using adb shell), perform FTP upload <LOOP_COUNT> times:						#
#laptop$ adb shell												#
#dut$ cd /data													#
#dut$ x=1; while [ $x -le <LOOP_COUNT> ]; 									#
#do ftpput -u ftptest -p ftppassword <FTP_SRV_IP_ADDR> file_test_put.bin file_test.bin; 			#
#x=$(( $x + 1 )); sleep 2; done.										#
#################################################################################################################


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
SUPP_scan_process

# Set key_mgmt according to network security
SUPP_define_key_mgmt

#Set pairwise and group according to encryption
SUPP_define_encryption

echo "Connecting to the secured WLAN .."
SUPP_connect_network

# Check step2 result
TR_check_connection

#################
# Test step3	#
#################

# check_iw_install
sleep 1


#################
# Test step4	#
#################

echo "Launch download process"
MISC_download_process
read -p "Please provide IP address of FTP_SRV" FTP_SRV_IP_ADDR

# test result TBD

#################
# Test step5	#
#################

echo "Launch upload process" 
MISC_upload_process

# test result TBD







