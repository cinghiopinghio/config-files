#!/usr/bin/env bash

LOCATION=${XDG_CONFIG_HOME:-${HOME}/.config}/rofi/scripts
echo ${LOCATION}

menu="\
1. Bookmarks 🕮
2. Search the web 🌍
3. Password Store 🔒 🔑
4. LaTeX manuals 📚
5. Kill'em All 🕱
6. Qalc(ulate) ⌨
7. SystemCtl 🖥\
"

choice=$(echo "$menu" | rofi -dmenu -i -p '☰' -mesg 'What are you looking for?')

case $choice in
  1*)
    ${LOCATION}/bufi
    ;;
  2*)
    . ${LOCATION}/web-search
    ;;
  3*)
    ${LOCATION}/rofi-pass
    ;;
  4*)
    ${LOCATION}/texgetdoc
    ;;
  5*)
    ${LOCATION}/killbill
    ;;
  6*)
    rofi -show calc -modi "calc:qalc -t"
    ;;
  7*)
    ${LOCATION}/scudmenu
    ;;
  *)
    ;;
esac
