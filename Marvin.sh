#! /bin/bash

cd $(dirname $0)
. ./lib/misc.sh

clear

MISC_initialize_param $1 $2 $3 $4

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
	echo -e "\n Your choice : "
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
	2) echo -e "Data Transfer Over Internet - Wlan \n Feasibility study in progress.. " ; sleep 2 ; ./Marvin.sh $verb $dut1 $locat $time ;;
	3) echo -e "Configure System - Config WLAN - WLAN Stand By \n Automation process for some TCDs is aborted, or pending for feasibility study" ; sleep 2 ; ./Marvin.sh $verb $dut1 $locat $time ;;
	4) echo -e "Provision Device - MAC adresses provisioning \n Aborted - will not be implemented!" ; sleep 2 ; ./Marvin.sh $verb $dut1 $locat $time ;;
	5) ./UC/Config_Wlan.sh $verb $dut1 $locat $time ;;
	0) exit ;;
esac


exit








































