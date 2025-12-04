#/bin/bash
foreground=${xrdb:color7:#222}
TUN=$(ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')
if [ "$TUN" = "tun0" ]; then
	echo "$foreground$(ifconfig tun0 | grep inet | grep netmask | awk '{print $2}')%{u-}"
else
	echo "DISCONNECTED"

fi
