#!/usr/bin/env bash

case `hostname -s` in
  spin|jupyter)
    . ~/.bashrc
    ;;
  giove)
    . ~/.bashrc
    ;;
esac

. ~/.shell/vars

export PATH=$PATH:$(find -L ~/.local/bin -type d | tr '\n' ':' | sed 's/:$//')
export PATH=$PATH:${HOME}/.gem/ruby/2.2.0/bin/
