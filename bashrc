# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ----------------------------------------
# COMPLETION
# ----------------------------------------
# {{{

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# autocomplete marks
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
complete -F _completemarks j jump unmark

# }}}

#save display variable in .env_var
function save-vars {
  VARS="SSH_CLIENT SSH_TTY SSH_AUTH_SOCK SSH_CONNECTION DISPLAY"
  for var in ${VARS};
  do
    (eval echo $var=\$$var) |\
        gawk 'BEGIN{FS="="}{if ($2!=""){print "export "$1"=\""$2"\""}}'
  done 1> /tmp/envvars
}

# ----------------------------------------------------
# PROMPT
# ----------------------------------------------------
#{{{
# uncomment for a colored prompt, if the terminal has the capability; 
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

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O
[ -f ~/.shell/colors ] && . ~/.shell/colors

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
User="\u"
Host="\h"

#command -v git >/dev/null 2>&1 && source ~/.local/bin/git-prompt
command -v __git_ps1 >/dev/null 2>&1 && GitBranch='$(__git_ps1)' || GitBranch=''

case ${HOSTNAME/.*/} in
  'arcinghio') HostColor=$Green ;;
  'moma')      HostColor=$IGreen ;;
  'mercurio')  HostColor=$Blue  ;;
  'quantumcl') HostColor=$Yellow;;
  'bunet')     HostColor=$Red   ;;
  *)           HostColor=$On_Red ;;
esac

export PS1=$HostColor$Host$Red$GitBranch' '$Yellow$PathShort$Color_Off' '

#}}}

# export some variables

[ -f ~/.shell/commons ] && . ~/.shell/commons
