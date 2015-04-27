#!/usr/bin/env bash

case `hostname -s` in
  quantumcl)
    . ~/.bashrc
    . ve/bin/activate
    ;;
  giove)
    . ~/.bashrc
    . ve/bin/activate
    ;;
esac

export PATH=$PATH:$(find -L ~/.local/bin -type d | tr '\n' ':' | sed 's/:$//')
export PATH=$PATH:${HOME}/.gem/ruby/2.2.0/bin/

