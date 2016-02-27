#! /bin/bash

# Initialise color vars
function MISC_get_colors ()
{
	red='\033[31;7m'
	green='\033[32;7m'
	blue='\033[34;7m'
	spec='\033[33;7m'
	noc='\033[0m'
}

# Download process for FTP test cases
function MISC_download_process ()
{
	adb -s $dut1 shell cd /data
	x=1 
	while [ $x -le 10 ] 
	do 
		adb -s $dut1 shell ftpget -u ftptest -p ftppassword $FTP_SRV_IP_ADDR file_test.bin file_test.bin
		adb -s $dut1 shell ls -l file_test.bin
		adb -s $dut1 shell rm file_test.bin 
		x=$(( $x + 1 ))
		sleep 2
	done
}

# Upload process for FTP test cases
function MISC_upload_process ()
{
	adb -s $dut1 shell cd /data
	x=1 
	while [ $x -le $LOOP_COUNT ]									
	do 
		adb -s $dut1 shell ftpput -u ftptest -p ftppassword $FTP_SRV_IP_ADDR file_test_put.bin file_test.bin			
		x=$(( $x + 1 ))
		sleep 2 
	done
}

# Prompt user for a static IP (needed for one specific TCD)
function MISC_get_static_ip ()
{
	read -p "Please provide an IP-address outside of AP DHCP range" ip_sta
	adb -s $dut1 shell busybox ifconfig wlan0 $ip_sta
}

# Auto-genarated test reports
function MISC_generate_report ()
{
	passed="PASS"
	result=`printf "| %-61s| %-6s\n" $tcname $passed`
	jour=`date +%F`
	timestamp=`date +%x_%X`
	mkdir -p $locat/Reports/$jour
	echo -e "$timestamp  $result" >> $locat/Reports/$jour/"report - $time"
}

# Special management for failed results
function MISC_generate_report_failed_result ()
{
	passed="FAIL"
	result=`printf "| %-61s| %-6s\n" $tcname $passed`
	jour=`date +%F`
	timestamp=`date +%x_%X`
	mkdir -p $locat/Reports/$jour
	echo -e "$timestamp  $result" >> $locat/Reports/$jour/"report - $time"
}

# Initiation of the session data
function MISC_initialize_param ()
{
	verb=$1
	dut1=$2
	locat=$3
	time=$4
}

# Special initiation of the session data
function MISC_initialize_param_extra ()
{
	verb=$1
	dut1=$2
	locat=$3
	time=$4
	param=$5
}

# Wait for user readiness to resume the script (press any key)
function MISC_wait_press_key ()
{
	echo -e "\n"${spec}"Press any key to continue.." ${noc}"\n"
	read -n1 x
}

# Activate verbose mode (if chosen from start)
function MISC_verbose_on ()
{
	
	case $verb in
		1) sortie="null" ;;
		2) sortie="stdout" ;;
		3) sortie="stdout" ; set -v ;;
	esac
}

# Deactivate verbose mode (if chosen from start)
function MISC_verbose_off ()
{
	if [ $verb -eq 3 ]
	then
		set +v
	fi
}

function MISC_test_complete_pass ()
{
	echo -e "\n${green}$tcname result = PASS ${noc} \n"
}

function MISC_test_complete_fail ()
{
	echo -e "\n${red}$tcname result = FAIL ${noc} \n"
}

function MISC_validateIP()
 {
         local ip=$1
         local stat=1
         if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                OIFS=$IFS
                IFS='.'
                ip=($ip)
                IFS=$OIFS
                [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
                && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
                stat=$?
        fi
        return $stat
}