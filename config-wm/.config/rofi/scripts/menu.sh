#!/usr/bin/env bash

. ~/.shell/vars
LOCATION=${XDG_CONFIG_HOME:-${HOME}/.config}/rofi/scripts

menu="\
1. Bookmarks\x0icon\x1fbookmarks
2. Documents\x0icon\x1fdocument
3. Search the web\x0icon\x1fweb-browser
4. Password Store\x0icon\x1fpassword
5. LaTeX manuals\x0icon\x1ftext-x-tex
6. Kill'em All\x0icon\x1fstop
7. Screenshot\x0icon\x1fgscreenshot
8. SystemCtl\x0icon\x1fkcontrol\
"

choice=$(echo -e "$menu" | rofi -dmenu -i -p '☰' -mesg 'What are you looking for?' -show-icons)

case $choice in
  1*)
    ${LOCATION}/bufi 2>>/dev/null
    ;;
  2*)
    rofi -show docufi -modi "docufi:${LOCATION}/docufi.sh"
    ;;
  3*)
    . ${LOCATION}/web-search
    ;;
  4*)
    ${LOCATION}/rofi-pass
    ;;
  5*)
    ${LOCATION}/texgetdoc
    ;;
  6*)
    ${LOCATION}/killbill
    ;;
  7*)
    grim ~/Downloads/$(date +'screenshot-%Y-%m-%d-%H%M%S.png')
    # grim -g "$(slurp)" ~/Downloads/$(date +'screenshot-%Y-%m-%d-%H%M%S.png')
    ;;
  8*)
    ${LOCATION}/scudmenu
    ;;
  *)
    ;;
esac
