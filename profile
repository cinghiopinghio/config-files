#!/usr/bin/env bash
[ `hostname -s` = 'quantumcl' ] && . ~/.bashrc
[ `hostname -s` = 'quantumcl' ] && . ve/bin/activate

export PATH=$PATH:$(find -L ~/.local/bin -type d | tr '\n' ':' | sed 's/:$//')
export PATH=$PATH:${HOME}/.gem/ruby/2.2.0/bin/

