#!/usr/bin/env bash

# add bookmarks to buku from opened tabs


RECOVERY_FILE=(${HOME}/.mozilla/firefox/*.default*/sessionstore-backups/recovery.jsonlz4)

URL=$(lz4jsoncat ${RECOVERY_FILE} |\
    jq --raw-output '.windows[] | .tabs[] | .entries[] | "<b>" + .title + "</b> <i>" + .url+"</i>"' |\
    sed 's/&/&amp;/g' |\
    rofi -dmenu -i -markup-rows -format "p" |\
    awk '{print $NF}')

buku -a "${URL}"

AN_ID=$(buku -s "${URL}" -j | jq '.[0] | .index')
python ${HOME}/.config/rofi/scripts/get_moz_icons.py ${AN_ID}
