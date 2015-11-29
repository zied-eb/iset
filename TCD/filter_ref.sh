#! /bin/bash

cd $(dirname $0)
clear
echo -e "Please make sure to set your Access Point with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = $1 \n"

echo -e "- <80211_PROTO> = 802.11 $1 \n"

sleep 3

echo -e "\nPress any key to continue.. \n"

read -n1 x

ban="AP_2G4_"$1"_BAND"
dut1=$2
./Reference/FT_CWS_WLAN_STA_FNC_FILTERING___REF.sh $ban $dut1






#SETUP:
#- AP:
#- is a WiFi acess point
#- WPA2-AES protected
#- broadast SSID <SSID> on 2.4Ghz band on a random channel in 1 to 11
#- has the MAC address <DUT_MAC_ADDR>
#- DUT:
#- is connected to <SSID>
#- has "tcpdump" installed on (4)
#- SERVER:
#- is a Linux laptop
#- connected on <SSID>
#- has the MAC address <SRV_MAC_ADDR>
#- has the IP address <SRV_IP_ADDR>
#- has following files installed in the SAME directory (they are all available on sharepoint):
#- "multi_hex_inject" tool installed, with execution permissions (chmod 777 multi_hex_inject)
#- "hexinject", with execution permissions (chmod 777 hexinject)
#- LAPTOP
#- is a laptop USB-connected to DUT
#- with "adb" installed on running on root mode (5) (only needed if dealing with a "userdebug" build)
