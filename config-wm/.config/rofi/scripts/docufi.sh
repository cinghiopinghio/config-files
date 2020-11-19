#!/usr/bin/env sh

LISTCMD=""
HISTFILE="${HOME}/.cache/docufi"

if [[ $1 == "" ]]; then
  echo -en "\x00prompt\x1fSession ${USER}:\n"
  echo -en "\0markup-rows\x1ftrue\n"
  if [ -f ${HISTFILE} ]; then
    sed "s/$/\x0icon\x1ftimer/" ${HISTFILE}
  fi

  # nvim/vim history
  sed '1d' ${HOME}/.cache/neomru/file | sed -e "s/$/\x0icon\x1fnvim/"

  # zathura history
  sed -e "/^\[.home.*\]$/!d" -e "s/^\[\(.*\)\]$/\1\x0icon\x1fapplication-pdf/" .local/share/zathura/history

  if command -v fd >>/dev/null 2>&1;
  then
    /usr/bin/fd --extension pdf --extension ps --extension docx --extension tex --color never "" ${HOME} | \
      sed -e "s/pdf$/pdf\x0icon\x1fapplication-pdf/" \
        -e "s/ps$/ps\x0icon\x1fapplication-postscript/" \
        -e "s/tex$/tex\x0icon\x1ftext-x-tex/" \
        -e "s/docx$/docx\x0icon\x1fapplication-wps-office.docx/"
  else
    find ${HOME} -type f -iname \*.pdf -not -path ".cache" -not -path ".mozilla" 2>>/dev/null
  fi
else
  killall rofi
  case "${1}" in
    *.py|*.tex|*.md)
      . ~/.shell/vars && nvim-qt "${1}" &
      ;;
    *)
      . ~/.shell/vars && xdg-open "${1}" &
      ;;
  esac

  if [ -f ${HISTFILE} ];
  then
    sed -i "1i${1}" ${HISTFILE}

    TMP=`mktemp -p /tmp docufi.XXXXX`
    # remove duplicates
    awk '!seen[$0]++' ${HISTFILE} > ${TMP}
    rm ${HISTFILE}
    # mv ${TMP} ${HISTFILE}
    head -50 ${TMP} > ${HISTFILE}
  else
    echo ${1} > ${HISTFILE}
  fi
fi

# vim: ft=sh
