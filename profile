export PATH=$PATH:$(find -L ~/.local/bin -type d | tr '\n' ':' | sed 's/:$//')
