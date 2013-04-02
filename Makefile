SHELL := /bin/bash
Local=${PWD}

main: 
	@echo -e "Usage:\n\
	  make install\n\n\
	Warning: this will delete all your config files\n"

install: ivim ibash igit iscreen ilatex izsh

ivim:
	@$(call linking,${Local}/vimrc,~/.vimrc)
	@$(call linking,${Local}/vim,~/.vim)

ibash:
	@$(call linking,${Local}/bashrc,~/.bashrc)
	@$(call linking,${Local}/aliases,~/.aliases)

igit:
	@$(call linking,${Local}/gitconfig,~/.gitconfig)
	@$(call linking,${Local}/gitignore,~/.gitignore)
	@$(call linking,${Local}/git-prompt.sh,~/.git-prompt)

iscreen:
	@$(call linking,${Local}/screenrc,~/.screenrc)

ilatex:
	@$(call linking,${Local}/latexmkrc,~/.latexmkrc)

izsh:
	@$(call linking,${Local}/zshrc,~/.zshrc)

help: main


linking=					\
	in=$1;					\
	out=$2;					\
	echo "Installing $$out configuration files";\
	already=$$(readlink $$out);		\
	if [[ $${already} != $${in} ]];\
	then					\
	  read -p "Remove $${out}? (y/n)";	\
	  [ "$${REPLY}" != "y" ] && exit 0;	\
	  rm -rf $$out;				\
	  ln -s $$in $$out;			\
	else					\
	  echo "Already installed";		\
	fi			
