

SETUP:
- AP:
- is a WiFi acess point
- WPA2-AES protected
- broadast SSID <SSID> on 2.4Ghz band on a random channel in 1 to 11
- has the MAC address <DUT_MAC_ADDR>
- DUT:
- is connected to <SSID>
- has "tcpdump" installed on (4)
- SERVER:
- is a Linux laptop
- connected on <SSID>
- has the MAC address <SRV_MAC_ADDR>
- has the IP address <SRV_IP_ADDR>
- has following files installed in the SAME directory (they are all available on sharepoint):
- "multi_hex_inject" tool installed, with execution permissions (chmod 777 multi_hex_inject)
- "hexinject", with execution permissions (chmod 777 hexinject)
- LAPTOP
- is a laptop USB-connected to DUT
- with "adb" installed on running on root mode (5) (only needed if dealing with a "userdebug" build)



#########################################################################################################################
#							PROCEDURE							#
#1- If <APK_TO_USE> is different from "No apk to use", from LAPTOP, install it on DUT. Otherwise, go to step2.		#
#laptop$ adb install -r <APK_TO_USE>											#
#Once installed, lauch application from DUT UI.										#
#2- Monitor DUT wifi interface traffic.											#
#From LAPTOP, perform following command:										#
#laptop$ adb shell tcpdump -exnvi wlan0 | grep -ie "<SRV_MAC_ADDR>"							#
#3- Turn on DUT screen and prevent it from switching off (1)								#
#4- On SERVER, go in the directory that contains the "multi_hex_inject" tool.						#
#Then start it and wait for it to finish:										#
#server$ sudo ./multi_hex_inject --test <TEST_INDEX> <DUT_MAC_ADDR>							#
#5- Restart "tcpcdump" on DUT using same commands as described in step 2						#
#6- Switch off DUT screen by pressing power button									#
#7- On SERVER, restart packets injection using same commands as described in step 4 and wait for it to finish		#
#########################################################################################################################


# install required app
adb -s $1 install -r $2

# 
while [  ]
do
	adb shell input keyevent 26
done
