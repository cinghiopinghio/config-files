# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    lgrey="\[\033[00m\]"
    dgrey="\[\033[00;30m\]"
    dred="\[\033[00;31m\]"
    dgreen="\[\033[00;32m\]"
    dyellow="\[\033[00;33m\]"
    dblue="\[\033[00;34m\]"
    dlred="\[\033[00;35m\]"
    dlblue="\[\033[00;36m\]"
    dwhite="\[\033[00;37m\]"
    grey="\[\033[01;30m\]"
    red="\[\033[01;31m\]"
    green="\[\033[01;32m\]"
    yellow="\[\033[01;33m\]"
    blue="\[\033[01;34m\]"
    lred="\[\033[01;35m\]"
    lblue="\[\033[01;36m\]"
    white="\[\033[01;37m\]"
    case "$HOSTNAME" in
	    arcinghio)
		    prompt=$red
		    ;;
	    mercurio)
		    prompt=$green
		    ;;
	    *)
		    prompt=$grey
		    ;;
    esac

    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="${debian_chroot:+($debian_chroot)}${prompt}\u@\h${lgrey}:${dgreen}\w${lgrey}\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi



# svn editor variable:
export SVN_EDITOR=/usr/bin/vim
# editor variable:
export EDITOR=/usr/bin/vim


export PATH=$PATH:~/.local/bin


svnhist(){
  svn log | awk 'BEGIN{OFS="\t";ls=80}{if($2=="|"){printf("%4s\033[1;31m%12s\033[0m: (%s)  ",$1,$3,$5)}else{if($0!=""){if (length($0)<ls){add=""}else{add="..."};print substr($0,1,ls) add}}}' | sed -e '/------/d'
}

#save display variable in .env_var
function save-vars {
  VARS="SSH_CLIENT SSH_TTY SSH_AUTH_SOCK SSH_CONNECTION DISPLAY"
  for var in ${VARS};
  do
    (eval echo $var=\$$var) |\
        gawk 'BEGIN{FS="="}{if ($2!=""){print "export "$1"=\""$2"\""}}'
  done 1> /tmp/envvars
}

[[ $TERM=='screen' && -e /tmp/envvars ]] && source /tmp/envvars;


