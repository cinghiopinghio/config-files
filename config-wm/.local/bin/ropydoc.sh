#!/usr/bin/env bash

PYLOC="/usr/share/doc/python/html/"

CHOICE=$(fd --extension html . ${PYLOC} |\
    xargs grep "<title>" |\
    sed -e "s|^${PYLOC}\([0-9a-z./_-]*\):\s*<title>\(.*\)\s&.*|<b>\2</b> \1\x00icon\x1fapplications-python|" |\
    rofi -dmenu -markup-rows |\
    awk '{print $NF}')

if [[ "${CHOICE}" == "" ]]; then exit; fi

firefox "file://${PYLOC}${CHOICE}"
