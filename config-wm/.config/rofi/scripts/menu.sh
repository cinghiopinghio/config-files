#!/usr/bin/env bash

. ~/.shell/vars
LOCATION=${XDG_CONFIG_HOME:-${HOME}/.config}/rofi/scripts

menu="\
1. Bookmarks\x0icon\x1fuser-bookmarks
2. Documents\x0icon\x1fdocument
3. Search the web\x0icon\x1fweb-browser
4. Password Store\x0icon\x1fpassword
5. LaTeX manuals\x0icon\x1ftext-x-tex
6. Kill'em All\x0icon\x1fstop
7. Screenshot\x0icon\x1fgscreenshot
8. Printers queue\x0icon\x1fprinter
9. Open installed Archlinux pkgs web-pages\x0icon\x1farchlinux
A. Open installed Nvim Plugs web-pages\x0icon\x1fnvim
B. Open Python docs\x0icon\x1fapplications-python
C. Add new bookmark from Firefox history\x0icon\x1fbookmark-add
D. Search into installed icons\x0icon\x1fimage-x-icon\
"

choice=$(echo -e "$menu" | rofi -dmenu -i -p '' -mesg 'What are you looking for?' -show-icons -auto-select)

case $choice in
  1*)
    jbofi.sh
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
    ;;
  8*)
    system-config-printer --show-jobs --embedded
    ;;
  9*)
    ropkgs.sh
    ;;
  A*)
    roplug.sh
    ;;
  B*)
    ${BROWSER:-firefox} /usr/share/doc/python/html/library/index.html
    ;;
  C*)
    jbofi_add.sh
    ;;
  D*)
    icons.sh
    ;;
  *)
    ;;
esac
