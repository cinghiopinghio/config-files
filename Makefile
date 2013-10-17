SHELL := /bin/bash
Local=${PWD}

main: 
	@echo -e "Usage:\n\
	  make install\n\n\
	Warning: this will delete all your config files\n"

install: ivim ibash igit iscreen ilatex izsh iscripts ivifm ignuplot isvn imutt

ivim:
	@$(call linking,${Local}/vimrc,~/.vimrc)
	@$(call linking,${Local}/vim,~/.vim)

ibash:
	@$(call linking,${Local}/bashrc,~/.bashrc)
	@$(call linking,${Local}/aliases,~/.aliases)
	@$(call linking,${Local}/bookmarks,~/.bookmarks)
	@$(call linking,${Local}/profile,~/.profile)

igit:
	@$(call linking,${Local}/gitconfig,~/.gitconfig)
	@$(call linking,${Local}/gitignore,~/.gitignore)

iscreen:
	@$(call linking,${Local}/screenrc,~/.screenrc)

ilatex:
	@$(call linking,${Local}/latexmkrc,~/.latexmkrc)

izsh:
	@$(call linking,${Local}/zshrc,~/.zshrc)

iscripts:
	@$(call linking,${Local}/scripts,~/.local/bin/scripts)

ivifm:
	@$(call linking,${Local}/vifm/vifmrc,~/.vifm/vifmrc)
	@$(call linking,${Local}/vifm/colorschemes,~/.vifm/colorschemes)
	@$(call linking,${Local}/vifm/colors,~/.vifm/colors)

ignuplot:
	@$(call linking,${Local}/gnuplotting,~/.gnuplotting)
	@$(call linking,${Local}/gnuplot,~/.gnuplot)

isvn:
	@$(call linking,${Local}/svnconfig,~/.subversion/config)

imutt:
	@$(call linking,${Local}/mutt,~/.config/mutt)
	@$(call linking,${Local}/muttrc,~/.muttrc)



help: main


linking=\
	in=$1;\
	out=$2;\
	echo "Installing $$out configuration files";\
	already=$$(readlink $$out);\
	if [[ $${already} != $${in} ]];\
	then\
	  if [[ -e $${out} ]];\
	  then\
	    read -p "Remove $${out}? (y/n)";\
	    [ "$${REPLY}" != "y" ] && exit 0;\
	    rm -rf $$out;\
	    ln -s $$in $$out;\
	  else\
	    ln -s $$in $$out;\
	  fi;\
	  echo "Installed";\
	else\
	  echo "Already installed";\
	fi			
