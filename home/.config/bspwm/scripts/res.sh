#/bin/bash

echo "Definiendo pantallas..."
Primary=$(xrandr | grep primary | awk {'print $1'})
VGA=$(xrandr | grep VGA | awk {'print $1'})
HDMI=$(xrandr | grep HDMI | awk {'print $1'})


if [ "$Primary" = "$VGA" ]; then
	if [ $HDMI = "" ]; then
		echo "Estas son tus pantallas:"
    		echo "1: $Primary"
	elif
	    	echo "Estas son tus pantallas:"
	    	echo "1: $Primary"
    		echo "2: $HDMI"
	elif [ "$Primary" = "$HDMI" ]; then
		if [ $VGA = "" ]; then
		echo "Estas son tus pantallas:"
     		echo "1: $Primary"
	else
     	   	echo "Estas son tus pantallas:"
		echo "1: $Primary"
		echo "2: $VGA"
				fi
		fi
	fi
fi

echo "Elige número:"
read eleccion

if [ "$eleccion" = "1" ]; then
	echo "elegiste $Primary"
fi
