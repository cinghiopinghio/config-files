#!/usr/bin/env bash

case `hostname -s` in
  spin|jupyter|filoselle)
    . ~/.bashrc
    ;;
  *)
    . ~/.zshrc
esac

. ~/.shell/vars

export PATH=${PATH}:${HOME}/.local/bin
# export PATH=$PATH:${HOME}/.gem/ruby/2.2.0/bin/
