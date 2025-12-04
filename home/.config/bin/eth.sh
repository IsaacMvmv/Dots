#/bin/bash

#foreground=${xrdb:color7:#222}

IFACE=$(/sbin/ifconfig | grep wlan1 | awk '{print $1}' | tr -d ':')
if [ "$IFACE" = "wlan1" ]; then
	echo "$foreground$(/sbin/ifconfig wlan1 | grep "192.168" | awk '{print $2}')%{u-}"
else
	IFACE2=$(/sbin/ifconfig | grep wlan0 | awk '{print $1}' | tr -d ':')
		if  [ "$IFACE2" = "wlan0" ]; then
	echo "$foreground$(/sbin/ifconfig wlan0 | grep "192.168" | awk '{print $2}')%{u-}"
else
	echo "$foreground$(/sbin/ifconfig | grep "192.168" | awk '{print $2}')%{u-}"
	fi
fi

if [ "$IFACE" = "" ]; then
	echo "DISCONNECTED"
fi
