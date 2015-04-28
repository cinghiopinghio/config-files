#!/usr/bin/env bash

case `hostname -s` in
  quantumcl)
    . ~/.bashrc
    ;;
  giove)
    . ~/.bashrc
    ;;
esac

export PATH=$PATH:$(find -L ~/.local/bin -type d | tr '\n' ':' | sed 's/:$//')
export PATH=$PATH:${HOME}/.gem/ruby/2.2.0/bin/

