#!/bin/bash

SE_STATUS="$(safeeyes --status)"

if [[ "${1}" == "-t" ]]; then
  case "${SE_STATUS}" in
    Disabled*)
      safeeyes --enable &
      xautolock -enable &
      killall -SIGUSR2 dunst & # resume
      echo SCREEN
      ;;
    *)
      safeeyes --disable &
      xautolock -disable &
      killall -SIGUSR1 dunst & # pause
      echo "%{B#A00} SCREEN %{B-}"
      ;;
  esac
else
  case "${SE_STATUS}" in
    Disabled*)
      echo "%{B#A00} SCREEN %{B-}"
      ;;
    *)
      echo SCREEN
      ;;
  esac
fi
