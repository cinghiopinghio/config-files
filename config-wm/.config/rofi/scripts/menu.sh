#!/usr/bin/env bash

LOCATION=${XDG_CONFIG_HOME:-${HOME}/.config}/rofi/scripts
echo ${LOCATION}

menu="\
1. Bookmarks
2. Password Store
3. LaTeX manuals
4. Kill'em All
5. Qalc(ulate)\
"

choice=$(echo "$menu" | rofi -dmenu -i -p '>' -mesg 'What are you looking for?')

case $choice in
  1*)
    ${LOCATION}/bufi
    ;;
  2*)
    ${LOCATION}/rofi-pass
    ;;
  3*)
    ${LOCATION}/texgetdoc
    ;;
  4*)
    ${LOCATION}/killbill
    ;;
  5*)
    rofi -show calc -modi "calc:qalc -t"
    ;;
  *)
    ;;
esac
