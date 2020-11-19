#!/usr/bin/env bash

case `cat /etc/hostname` in
  spin|jupyter|filoselle|brancamenta)
    . ~/.bashrc
    ;;
  *)
    . ~/.zshrc
esac

. ~/.shell/vars
