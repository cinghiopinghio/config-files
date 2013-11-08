###########################################################        
# Options for Zsh

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS # ignore duplicates in history

eval `dircolors -b`

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

# PS1 and PS2
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
export PS1="%F{blue}$Host%F{yellow} %~$Folder "
export PS2="%F{blue}>%F{white}"

# Vars used later on by Zsh
export EDITOR="vim"
export BROWSER="firefox"
export XTERM="aterm +sb -geometry 80x29 -fg black -bg lightgoldenrodyellow -fn -xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso8859-15"

# add to PATH .local/bin and subdirectories
path+=($(find -L ~/.local/bin -type d))

##################################################################
# Stuff to make my life easier

# comand-extension completione
#zstyle ':completion::*:(vi|vim):*' file-patterns '*.tex' '*' '*'
#zstyle ':completion::*:(vi|vim):*' file-patterns '*~*.(aux|dvi|log|idx|pdf|rel|out)' '*'

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# ssh completion
hosts=$(awk '/^Host / {printf("%s ",$2)}' ~/.ssh/config 2>/dev/null)
zstyle ':completion:*:hosts' hosts $hosts

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema \
'[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'

##################################################################
# Key bindings
# http://mundy.yazzy.org/unix/zsh.php
# http://www.zsh.org/mla/users/2000/msg00727.html

#typeset -g -A key
#bindkey '^?' backward-delete-char
#bindkey '^[[1~' beginning-of-line
#bindkey '^[[5~' up-line-or-history
#bindkey '^[[3~' delete-char
#bindkey '^[[4~' end-of-line
#bindkey '^[[6~' down-line-or-history
#bindkey '^[[A' up-line-or-search
#bindkey '^[[D' backward-char
#bindkey '^[[B' down-line-or-search
#bindkey '^[[C' forward-char 
## completion in the middle of a line
#bindkey '^i' expand-or-complete-prefix

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
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish

# nice java fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

fi

# print the current directory in the terminal title
function precmd() {
    print -Pn "\e]2;..%2d\a"
}
##################################################################
# My aliases

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

# normal aliases
if [ -f ~/.aliases ];
then 
  source ~/.aliases
fi
# folder bookmarks
if [ -f ~/.bookmarks ];
then 
  source ~/.bookmarks
fi
