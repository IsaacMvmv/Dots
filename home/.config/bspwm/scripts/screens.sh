#/bin/bash

Principal=$(xrandr | grep primary | awk '{print $1}')
VGA=$(xrandr | grep VGA | awk '{print $1}')
HDMI=$(xrandr | grep HDMI | awk '{print $1}')
VGAconnected=$(xrandr | grep VGA | awk '{print $2}')
HDMIconnected=$(xrandr | grep HDMI | awk '{print $2}')
VGAisPrincipal=0
HDMIisPrincipal=0
VGAisconnected=0
HDMIisconnected=0


FILE=/tmp/screen.lock
if [[ -f $FILE ]];then
    xrandr --output $VGA --off
    xrandr --output $HDMI --off
    rm $FILE
    notify-send "Pantalla desacoplada" $HDMI $VGA
else

	#VGA

    if [ "$Principal" = "$VGA" ]; then
		VGAisPrincipal=1
	fi

	if [ "$VGAconnected" = "connected" ]; then
		VGAisconnected=1
	else
		VGAisconnected=0
	fi

	if [ "$VGAisPrincipal" = "0" ]; then
		if [ "$VGAisconnected" = "1" ]; then
			touch $FILE
			xrandr --output $VGA --auto --right-of $Principal
			feh --bg-fill "$(< "${HOME}/.cache/wal/wal")"
			notify-send "Pantalla acoplada" $VGA
		fi
	fi	
	
	#HDMI

	if [ "$Principal" = "$HDMI" ]; then
		HDMIisPrincipal=1
	fi

	if [ "$HDMIconnected" = "connected" ]; then
		HDMIisconnected=1
	fi

	if [ "$HDMIisPrincipal" = "0" ]; then
		if [ "$HDMIisconnected" = "1" ]; then
			touch $FILE
			xrandr --output $HDMI --auto --right-of $Principal
			feh --bg-fill "$(< "${HOME}/.cache/wal/wal")"
			notify-send "Pantalla acoplada" $HDMI
		fi
	fi
fi
