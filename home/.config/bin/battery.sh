#/bin/sh

B=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$B" = "11" ]; then
        notify-send BATEE
	sleep 60
fi

echo " $B%"

