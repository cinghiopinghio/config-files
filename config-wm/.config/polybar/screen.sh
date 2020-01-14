#!/bin/bash

source ~/.config/polybar/colors-gruvbox.sh

SE_STATUS="$(safeeyes --status)"
TEXT="%{T3}    %{T-}"

if [[ "${1}" == "-t" ]]; then
  case "${SE_STATUS}" in
    Disabled*)
      safeeyes --enable &
      xautolock -enable &
      killall -SIGUSR2 dunst 2>>/dev/null & # resume
      echo ${TEXT}
      ;;
    *)
      safeeyes --disable &
      xautolock -disable &
      killall -SIGUSR1 dunst 2>>/dev/null & # pause
      echo "%{B#A00}${TEXT}%{B-}"
      ;;
  esac
else
  case "${SE_STATUS}" in
    Disabled*)
      echo "%{B${RED}}${TEXT}%{B-}"
      ;;
    *)
      echo ${TEXT}
      ;;
  esac
fi
