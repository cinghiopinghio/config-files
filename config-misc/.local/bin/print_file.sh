#!/bin/sh

CMD=nwgdmenu
CMD="rofi -dmenu -i"
CMD="wofi --dmenu"

FILENAME="${1-XXX}"

LPOPTIONS="-o scaling=95 -o position=center"

function get_opts {
    option=$(lpoptions -p ${1} -l | ${CMD})
    if [[ "${option}" == "" ]]; then
        exit
    fi

    key=${option%%[/:]*}
    vals=( ${option##*:} )
    echo -n ${key}=
    echo ${vals[@]} | sed 's/\s/\n/g' | ${CMD} | sed 's/^*//'
}

# chose the printer
printer=$(lpstat -s | ${CMD} | cut -d' ' -f 3 | sed -e 's/:$//')

options=""
while true; do
    option=$(get_opts ${printer})
    if [[ ${option} == "" ]]; then
        break
    else
        options="${options} -o ${option}"
    fi
done

# print
lpr -P "${printer}" ${LPOPTIONS} ${options} "${FILENAME}"

# notify
notify-send -i document-print Printing "Printing <b>${FILENAME}</b> to printer ${printer}"
