#!/usr/bin/env bash

case $1 in
light)
	case $2 in
		up)
			light -A 5
			;;
		*)
			light -U 5
			;;
	esac
	VALUE=`light`
	VALUE=`printf %.0f%% ${VALUE}`
	APP=Brightness
	ICON=sunny
	TITLE="Brightness -- ${VALUE}"
	;;
volume)
	case $2 in
		up)
			pactl set-sink-volume 0 +5%
			;;
		*)
			pactl set-sink-volume 0 -5%
			;;
	esac
	VALUE=`pactl list sinks | grep Volume | head -1 | awk '{print $5}'`
	APP=Volume
	ICON=notification-audio-volume-medium
	TITLE="Volume -- ${VALUE}"
	;;
*)
	exit
	;;
esac

notify-send --hint int:value:${VALUE} -a "${APP}" "${TITLE}" --icon=${ICON} --expire-time=1000
