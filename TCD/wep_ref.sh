#! /bin/bash

cd $(dirname $0)
. ../lib/misc.sh

MISC_initialize_param_extra $1 $2 $3 $4 $5
MISC_get_colors

clear
echo -e "Please make sure to set your Access Point with the following config :\n"

echo -e "- <BAND> = 2.4Ghz \n"

echo -e "- <CHANNEL> = random in 1 2 3 4 5 6 7 8 9 10 11 \n"

echo -e "- <SECURITY> = $param \n"

echo -e "- <80211_PROTO> = 802.11bgn (mixed) \n"

sleep 1

MISC_wait_press_key

./Reference/FT_CWS_WLAN_STA_FNC_CNX___REF.sh $verb $dut1 $locat $time $param

