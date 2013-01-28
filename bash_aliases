
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -lFh'

# MC exits in the same directory
if [ -e /usr/lib/mc/mc-wrapper.sh ]; then
  alias mc='. /usr/lib/mc/mc-wrapper.sh'
fi

alias :wq='exit'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ml='matlab -nodesktop -nosplash'
alias scr='save-vars; screen -R'

alias head1='head -1'
alias tail1='tail -1'
alias du='du -h'
alias du1='du --max-depth=1 -h'
alias du0='du --max-depth=0 -h'

#zipped files
ztail(){
zcat $1 | tail
}
zhead(){
zcat $1 | head
}

# python aliases
alias ipynb='ipython2 notebook --pylab inline'

alias uruake='urxvt -geometry 128x29+100+0 -pe kuake &'

##################
# bash functions #
##################

# show all colors on terminal
sh-colors(){
for i in {1..255}; do echo -e "\e[38;5;${1};1m\e[48;5;${i}m    \e[0m\e[38;5;${i}m $i\e[0m"; done
}

# clean latex files
cleantex(){
RMFILES=$(ls *.aux *.bbl *.blg *.out *.log *.dvi *.toc 2>>/dev/null)
if [ "$RMFILES" == "" ];
then
  echo "Folder already clean, bye."
  exit 0
else
  echo $RMFILES
  read -p 'Do you want me to swip out those files??? [Y/n]'
  [ "$REPLY" == "y" ] && rm $RMFILES || echo "OK, bye!"
fi
}

# Multiple skypes
skp(){
PROGNAME=$FUNCNAME
USER=$1
if [[ "$USER" == mauro || "$USER" == cinghio ]];
then
  DBDIR=~/.config/Skype-$USER
  skype --dbpath=$DBDIR
else
  echo $PROGNAME: user $USER unknown 1>&2
  echo Usage: $PROGNAME username
  echo username = mauro / cinghio
#  exit 1
fi
}

# git remove submodules
rm_git_submodules(){
submodulepath=$1
git rm --cached $submodulepath
git config -f .git/config --remove-section submodule.$submodulepath
git config -f .gitmodules --remove-section submodule.$submodulepath
}
