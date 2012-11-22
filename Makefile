SHELL := /bin/bash
Local=${PWD}


main: 
	@echo "Usage:\n\
	  make install\n\n\
	Warning: this will delete all your config files\n"

install:
	@$(call linking,${Local}/vimrc,~/.vimrc)
	@$(call linking,${Local}/bashrc,~/.bashrc)
	@$(call linking,${Local}/bash_aliases,~/.bash_aliases)
	@$(call linking,${Local}/gitconfig,~/.gitconfig)
	@$(call linking,${Local}/screenrc,~/.screenrc)

help: main


linking=			\
	in=$1;			\
	out=$2;			\
	echo "Installing $$out configuration files";\
	if [ -f ${out} ];	\
	then			\
	  read -p "Remove $${out}? (y/n)";\
	  [ "$${REPLY}" != "y" ] && exit 0;\
	  rm -f $$out;		\
	  ln -s $$in $$out;	\
	else			\
	  echo no;		\
	fi			
