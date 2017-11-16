SHELL:=/bin/bash
Local=${PWD}

PKGS=$(wildcard config-*)
CMDS=$(patsubst config-%, %, $(PKGS))

.PHONY=$(PKGS)

main: 
	@echo -e "Usage:\n\
	  make install\n\n\
	Warning: this will delete all your config files\n"


install: $(CMDS)

$(CMDS):
	@echo Installing $(@)
	./stowsh/stowsh -v -s -t $(HOME) config-$(@)


help: main
