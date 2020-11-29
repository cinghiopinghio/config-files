#!/usr/bin/env bash

ROFICMD="wofi --dmenu"
ROFICMD="rofi -dmenu -show-icons"

ICONS=`(\
  fd --type d --max-depth 1 . /usr/share/icons/;\
  fd --type d --max-depth 1 . ~/.local/share/icons/;\
  ) | ${ROFICMD}`

ICON=`fd -e png -e svg -e jpg . $ICONS |\
  sed -e 's/\(.*\)\/\([^.]*\).\([a-z]*\)/\1\/\2\.\3\x0icon\x1f\2/'|\
  ${ROFICMD}`

echo $ICONS
echo $ICON
