#!/usr/bin/env bash

case $1 in
    activated)
        notify-send -i screensaver -a waybar Idle-Safe "Screensaver deactivated"
        safeeyes --disable
        ;;
    deactivated)
        notify-send -i screensaver -a waybar Idle-Enabled "Screensaver [re]activated"
        safeeyes --enable
        ;;
esac


