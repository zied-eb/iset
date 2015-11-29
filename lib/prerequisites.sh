#! /bin/bash

# Prepare the script for all DUT connection possibilities (no device, only one device, two or more devices connected)
function PRE_check_device ()
{
	DUT=false
	nb=0
	while [ $DUT = false ] && [ $nb -lt 4 ]
	do
		((nb++))
		connected=`adb devices | wc -l`
		if [ $connected -eq 3 ]
		then
			dut1=`adb devices | tail -n +2 | cut -f1`
			DUT=true
			echo "OK, DUT is connected"
			adb -s $dut1 root >/dev/null 2>&1
		elif [ $connected -ge 4 ]
		then
			DUT=true
			read -p "Do you need more than one device for your test (y/n) : " number
		
			if [ $number = "y" ]
			then
				echo -e "\vPlease select (copy/paste) the main device DUT-1 from the following list: \v "
				adb devices | tail -n +2
				read -p "Serial : " dut1
				adb -s $dut1 root >/dev/null 2>&1

				# Input of a bad value for DUT1
				if [ $? -eq 0 ]
				then
					echo -e "\vOK, please select (copy/paste) the secondary device DUT-2 from the list: "
					adb devices | tail -n +2
					read -p "Serial : " dut2

					# Test if DUT2 was selected the same as DUT1
					if [ $dut2 = $dut1 ]
					then

						echo "You have selected the same device, twice !"
						exit
					fi
					
					adb -s $dut2 root >/dev/null 2>&1
					# Input of a bad value for DUT2
					if [ $? -eq 0 ]
					then
						echo "OK"
					else 
						echo "Bad choice !"
						exit
					fi
				else
					echo "Bad choice !"
					exit 
				fi
			elif [ $number = "n" ]
			then
				echo "Please select (copy/paste) a unique device to test from the list: "
				adb devices | tail -n +2
				read -p "Serial : " dut1
				adb -s $dut1 root >/dev/null 2>&1
				if [ $? -ne 0 ]
				then
					# Input of a bad DUT
					echo "Bad choice !"
					exit
				fi
			else
				# Input a choice different than y or n
				echo "Bad choice !"
				exit
			fi

		else
			echo "DUT is not connected, please connect it"	
			sleep 3
		fi
	done

	if [ $DUT = false ]
	then
		echo "Timeout: no device connected!"
		echo "Have a nice day !"
		exit
	fi

}




###############################################

# Confirm that Wifi is OFF before test execution
function PRE_check_wifi_status ()
{

	adb -s $dut1 shell busybox ifconfig | grep ^wlan0
	if [ $? -eq 0 ]
	then	
		adb -s $dut1 shell svc wifi disable
		sleep 3
		adb -s $dut1 shell busybox ifconfig | grep ^wlan0
		if [ $? -eq 0 ]
		then
			echo -e "${red} Unable to turn OFF wifi, this test could not be executed ${noc}"
			exit
		else
			echo "OK, Wifi is OFF and ready "		
		fi

	else
		echo "Wifi is already OFF"
	fi


	sleep 1

}

##############################################

# Check that Wifi service is running before test execution
function PRE_check_wifi_service ()
{

	adb -s $dut1 shell service list | grep 'android.net.wifi.IWifiManager'

	if [ $? -eq 0 ]
	then
		echo "OK, Wifi service is running !"
	else
		echo -e "${red} Wifi service is not running ! ${noc}"
		echo "Sorry ! This test could not be executed"
		exit
	fi
	sleep 1

}


###########################################

# Remove "wpa_supplicant.conf" file before test execution
function PRE_check_sup_conf_file ()
{
	adb -s $dut1 shell find /data/misc/wifi/wpa_supplicant.conf | grep ^"/"
	if [ $? -eq 0 ]
	then
		adb -s $dut1 shell rm /data/misc/wifi/wpa_supplicant.conf
		adb -s $dut1 shell find /data/misc/wifi/wpa_supplicant.conf | grep ^"/"
		if [ $? -ne 0 ]
		then
			echo "OK, conf file deleted !"
		else
			echo -e "${red} The conf file could not be deleted ${noc}"
			echo "Sorry ! This test could not be executed"
			exit
		fi
	else
		echo "OK, conf file does not exist !"
	fi
	sleep 1
}


##########################################

# Confirm that no networks remembered before test execution
function PRE_remove_remembered_networks ()
{
	## enable wifi to remove remembered networks
	adb -s $dut1 shell busybox ifconfig | grep ^wlan0
	if [ $? -ne 0 ]
	then
		adb -s $dut1 shell svc wifi enable
	fi
	sleep 1
	## remove all remembered networks
	adb -s $dut1 shell wpa_cli IFNAME=wlan0 remove_network all
	if [ $? -eq 0 ] 
	then
		check_remove=`adb -s $dut1 shell wpa_cli IFNAME=wlan0 list_network | wc -l`
		if [ $check_remove -le 2 ]
		then
			echo "OK, no remembered network"
			sleep 1
			adb -s $dut1 shell svc wifi disable
		fi
	else
		echo -e "Error! unable to remove all networks \n It might be something wrong, please try again to be sure"
		exit
	fi

	sleep 1
}

##########################################

# Check that iw application is installed before test execution
function PRE_check_iw_install ()
{
	#testiw=`adb -s $dut1 shell find /system/bin/iw | wc -l`
	adb -s $dut1 shell ls /system/bin/iw
	if [ $? -ne 0 ]
	then
		echo "Please place the \"iw\" app file under the following path $HOME/bin "
		existing=false
		nbr=0	
		while [ $existing = false ] && [ $nbr -lt 3 ]
		do
			read -n1 -p "Copy it, then press any key to continue .." goo
			((nbr++))
			if [ -e ../iw ]
			then
				echo "Thank you ! "
				echo "Copying iw file to DUT system"
				adb -s $dut1 push iw /system/bin
				$existing=true
				sleep 1

				# Check if adb push is successful
				adb -s $dut1 shell ls /system/bin/iw
				if [ $? -ne 0 ]
				then
					echo "Sorry! iw could not be copied to DUT system"
					exit
				fi
			fi
		done
	else
		echo "OK, iw app already exist in the DUT system !"
	fi
	sleep 1
}

##########################################


