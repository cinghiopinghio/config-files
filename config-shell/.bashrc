# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# export some variables
[ -f ~/.shell/commons ] && . ~/.shell/commons

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# bash options
shopt -s cdspell                    # autocorrects cd misspellings
shopt -s checkwinsize               # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist                    # save multi-line commands in history as single line
shopt -s dotglob                    # include dotfiles in pathname expansion
shopt -s expand_aliases             # expand aliases
shopt -s extglob                    # enable extended pattern-matching features
shopt -s nocaseglob                 # pathname expansion will be treated as case-insensitive
shopt -s histappend                 # Append History instead of overwriting file.
shopt -s no_empty_cmd_completion    # No empty completion

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

# set up fzf bin path, completion, key bindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# autocomplete marks
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
complete -F _completemarks j jump unmark

# vex completion

if hash vex 2>/dev/null; then
  eval "$(vex --shell-config bash)"
fi

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
  'susto') HostColor=$Green ;;
  'moma')      HostColor=$IGreen ;;
  'spin')      HostColor=$Blue  ;;
  'dingo')     HostColor=$Yellow;;
  *)           HostColor=$On_Red ;;
esac

function virtualenv_prompt() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo $Red"(${VIRTUAL_ENV##*/}) "$Color_Off
    elif [ -n "${CONDA_DEFAULT_ENV}" ]; then
        echo $Red"(${CONDA_DEFAULT_ENV##*/}) "$Color_Off
    fi
}

export PS1=$(virtualenv_prompt)$HostColor$Host$Red$GitBranch' '$Yellow$PathShort$Color_Off' '

#}}}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
