#! /bin/bash

cd $(dirname $0)
. ./misc.sh

MISC_initialize_param 


choix=20
while [ $choix -gt 5 ]
do
	clear
	echo -e "Please select a Use case to go through : \n"
	echo "1) Configure System - WLAN - ON-OFF"
	echo "2) Data Transfer Over Internet - Wlan"
	echo "3) Configure System - Config WLAN - WLAN Stand By"
	echo "4) Provision Device - MAC adresses provisioning"
	echo "5) Configure System - Config WLAN"
	echo "0) Quit"
	read choix
	if [ $choix -gt 5 ]
	then
		echo "Wrong choice !"
		sleep 1
	fi
	
done


echo -e "\n"


case $choix in
	1) ./UC/ON_OFF.sh $verb $dut1 $locat $time ;;
	2) echo -e "Data Transfer Over Internet - Wlan \n Feasibility study in progress.. " ;;
	3) echo -e "Configure System - Config WLAN - WLAN Stand By \n Automation process for some TCDs is aborted, or pending for feasibility study" ;;
	4) echo -e "Provision Device - MAC adresses provisioning \n Aborted - will not be implemented!" ;;
	0) exit ;;
esac


exit








































