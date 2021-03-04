#!/bin/sh

# jbofi: a better buku-rofi wrapper
# depends on:
# - jq
# - lz4jsoncat
# - frece
#
# to use icons you need to save them as 
# `netloc`.png in `~/.cache/bukuicon`

. ~/.shell/vars
XDG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"

FRECE_CACHE="${XDG_CACHE}/frece_jbofi.db"
ICON_CACHE="${XDG_CACHE}/bukuicon"
mkdir -p "${ICON_CACHE}"

SEP="|"
MESSAGE="Press <b><tt>Alt-n</tt></b> to add new bookmarks from Firefox"
DM_CDM="rofi -dmenu -i -markup-rows -eh 2 -sep ${SEP}"
DM_CDM="${DM_CDM} -kb-custom-1 Alt+n"
TITLE='<b>\(.title)</b>'
DESCR='<sup><i>\(.uri) \(.index)</i></sup>'
ICONS='\u0000icon\u001f/home/mauro/.cache/bukuicon/" + (.uri | sub("^.*://"; "") | sub("/.*$"; "") + ".png")'
JQ_ARGS=".[]| \"${TITLE}\n${DESCR}${ICONS} + \"${SEP}\""

# get history [frece]
if [ ! -f "${FRECE_CACHE}" ]; then
    tmpfile=`mktemp`
    frece init "${FRECE_CACHE}" "${tmpfile}"
    history_ind=""
    rm "${tmpfile}"
else
    history_ind=`frece print ${FRECE_CACHE} | tr '\n' ' '`
fi
history_jsn=`buku -j -p ${history_ind} | sed -e 's/}/}]/' -e 's/{/[{/'`

# choose
# (echo ${history_jsn} && buku -j -p) |\
#     sed -e 's/|//g' -e 's/&/&amp;/' |\
#     jq --join-output "${JQ_ARGS}" | grep -a ansa
# exit
choice=`(echo ${history_jsn} && buku -j -p) |\
    sed -e 's/|//g' -e 's/&/&amp;/' |\
    jq --join-output "${JQ_ARGS}" | ${DM_CDM} -mesg "${MESSAGE}"`

if [[ ${?} == '10' ]]; then
    ~/.local/bin/jbofi_add.sh
    exit
fi

choice=( `echo "${choice}" |\
    tail -1 |\
    sed -e 's/<[a-z/]*>//g' ` )

if [[ ${#choice[@]} == 0 ]]; then exit; fi

# open bookmark
${BROWSER:-firefox} ${choice[0]}
# using buku to open a link is slow
# buku -o ${choice[1]}

# update history
tmpfile=`mktemp`
echo "${choice[1]}" > "${tmpfile}"
frece update "${FRECE_CACHE}" "${tmpfile}"
frece increment "${FRECE_CACHE}" "${choice[1]}"
rm "${tmpfile}"

# search for images into the firefox cache
sleep 10
python ~/.config/rofi/scripts/get_moz_icons.py ${choice[1]}
