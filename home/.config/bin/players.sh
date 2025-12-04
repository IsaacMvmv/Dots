#!/bin/sh
#echo " $(curl -s https://www.mcstatus.io/status/rusos.onthewifi.com | grep 100 | awk '{print $1 $2 $3}')  "

echo "   $(cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status)   "
#echo $(timedatectl | grep "RTC time" | awk '{print $4}')
