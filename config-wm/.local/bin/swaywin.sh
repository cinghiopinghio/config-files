#!/usr/bin/env bash

JQARGS='recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")| "\(.id|tostring) "+.app_id+" "+.name'

case ${USE} in
    rofi)
        AWKARGS='{\
            printf("%s\x00%s\x1f\n",$0, $2)\
        }'
        ;;
    *)
        AWKARGS='{\
            if ( $2 != "" ) {\
            # cmd = "~/codes/fdicons/build/fdicons get-icon 32 -x svg,png "$2;\
            cmd = "fd -i --max-results 1 --glob \""$2".*\" /usr/share/icons/Numix-Circle/48";\
            cmd | getline icon; close(cmd);\
            printf(":img:%s:text: %s\n",icon, $0)\
            }\
        }'
        ;;
esac


if [[ "${@}" ]]; then
    con_id=`echo $@ | awk '{printf("%s", $2)}'`
    swaymsg -q "[con_id =${con_id}]" focus
else
    swaymsg -t get_tree |\
        jq -r "$JQARGS" |\
        awk "${AWKARGS}"
fi
