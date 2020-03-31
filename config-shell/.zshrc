###########################################################
# Options for Zsh

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS # ignore duplicates in history

if whence dircolors >/dev/null; then
  # GNU utils way
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
else
  # f***ing OSX/unix way
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

fpath=(${HOME}/.local/share/zsh $fpath)
autoload -U compinit
compinit
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
#setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt SH_WORD_SPLIT
setopt nohup


# ------------------------------
# PROMPT
# PS1 and PS2
# ------------------------------
# {{{
setopt prompt_subst
vcs_prompt(){
  while [[ ! -d .git && ! -d .svn && ! `pwd` = "/" ]]; do cd ..; done
  if [ -e ./.git ];
  then
    BRANCH=$(awk -F'/' '{print $NF}' .git/HEAD)
    echo '%F{red}[git]%f - %F{yellow}'$BRANCH'%f'
  elif [ -e ./.svn ];
  then
    echo '%F{red}[svn]%f'
  fi
}
export RPROMPT='$(vcs_prompt)'
Host="%m"
Folder="%f"
# Prompt color depends on HOST
case $HOST in
  "susto") hostColor="%F{green}"  ;;
  "moma")      hostColor="%F{green}"  ;;
  "spin")      hostColor="%F{blue}"   ;;
  "dingo")     hostColor="%F{magenta}"   ;;
  *)           hostColor="%F{red}"    ;;
esac
function virtualenv_prompt() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "%F{red}(${VIRTUAL_ENV##*/}) "
    fi
}
export PS1="$(virtualenv_prompt)$hostColor$Host%F{yellow} %~$Folder "
export PS2="%F{blue}>%F{white}"
# }}}

# ----------------------------------------
# export some env vars
# Vars used later on by Zsh
# hostname specific stuff
# ----------------------------------------
[ -f ~/.shell/commons ] && . ~/.shell/commons

##################################################################
# Completion
##################################################################
# {{{

# allow approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
#
# # tab completion for PID :D
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:kill:*' force-list always
#
# # cd not select parent dir
# zstyle ':completion:*:cd:*' ignore-parents parent pwd
#
# # ssh completion
hosts=$(awk '/^Host / {printf("%s ",$2)}' ~/.ssh/config 2>/dev/null)
zstyle ':completion:*:hosts' hosts $hosts

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema \
'[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'

# mark completion
function _completemarks {
  reply=($(ls $MARKPATH))
}
compctl -K _completemarks jump
compctl -K _completemarks unmark
# }}}

##################################################################
# Key bindings
# http://mundy.yazzy.org/unix/zsh.php
# http://www.zsh.org/mla/users/2000/msg00727.html
# {{{
typeset -g -A key
bindkey '^[[D'    backward-char
bindkey '^?'      backward-delete-char
bindkey "^[[1;3D" backward-word
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '^[[1~'   beginning-of-line
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[P'    delete-char        # for st term
bindkey '^[[3~'   delete-char
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '^[[6~'   down-line-or-history
bindkey '^[[B'    down-line-or-search
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal
bindkey '^[[4~'   end-of-line
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '^i'      expand-or-complete-prefix # completion in the middle of a line
bindkey '^[[C'    forward-char
bindkey "^[[1;3C" forward-word
bindkey '^R'      history-incremental-search-backward
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '^[[5~'   up-line-or-history
bindkey '^[[A'    up-line-or-search
bindkey "^[."     insert-last-word

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word


# from archlinux wiki
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}


key[Delete]=${terminfo[kdch1]}
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#    function zle-line-init () {
#        printf '%s' "${terminfo[smkx]}"
#
#    function zle-line-finish () {
#        printf '%s' "${terminfo[rmkx]}"
#    }
#    zle -N zle-line-init
#    zle -N zle-line-finish
#
#fi

# }}}

# print the current directory in the terminal title
# {{{
case $TERM in
  (*xterm* | *rxvt* | *st* | *alacritty* )

    # Write some info to terminal title.
    # This is seen when the shell prompts for input.
    function precmd {
      print -Pn "\e]0;%(1j,%j job%(2j|s|); ,)%~\a"
    }
    # Write command and args to terminal title.
    # This is seen while the shell waits for a command to complete.
    function preexec {
      printf "\033]0;%s\a" "$1"
    }

  ;;
esac

if [[ $TERM == xterm-termite ]]; then
	. /etc/profile.d/vte.sh
	__vte_osc7
fi
# }}}
##################################################################
# My aliases

# {{{
# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s pdf=zathura
alias -s eps=evince
alias -s sxw=abiword
alias -s doc=abiword
alias -s tex=$EDITOR
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# command L equivalent to command |less
alias -g L='|less'

# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'

# }}}
#
#

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim: fdm=marker
