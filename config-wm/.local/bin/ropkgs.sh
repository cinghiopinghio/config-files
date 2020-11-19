#!/usr/bin/env bash

choice=$(yay -Qi |\
    sed -e "s/^Name/- Name/" -e 's/^\([A-Z]\)/  \1/' -e "s/['\"]//g" -e 's/: \(.*\)/: \"\1\"/' -e 's/^        .*//' |\
    yaml2json |\
    jq --raw-output '.[] | "<b>\(.Name)</b> \(.Description) \(.URL)\u0000icon\u001f\(.Name)"' |\
    rofi -dmenu -markup-rows |\
    awk '{print $NF}')

if [[ ${choice} == "" ]]; then exit; fi

echo $choice
firefox ${choice}

echo
echo
