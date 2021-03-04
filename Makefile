SHELL := /bin/bash
Local := ${PWD}

PKGS := $(wildcard config-*)
CMDS := $(patsubst config-%,%,$(PKGS))

.PHONY: $(PKGS) $(CMDS) install help prepare main clean

LOCALBIN := $(abspath $(HOME)/.local/bin)
STOW := $(LOCALBIN)/stowsh
STOW_ARGS := -v -s -t $(HOME)

EMPTY :=
SPACE := $(EMPTY) $(EMPTY)


main:
	@echo -e "Usage:\n\
	  make install\n\
	or\n\
	  make [$(subst $(SPACE),|,$(CMDS))]\n\n\
	Warning: this will delete all your config files and all your broken links\n"


prepare: $(STOW)
	@echo Preparing the system to blow up


$(STOW):
	@echo Installing stowsh
	@echo from: https://github.com/mikepqr/stowsh
	mkdir -p $(LOCALBIN)
	curl "https://raw.githubusercontent.com/williamsmj/stowsh/master/stowsh" --output $(STOW)
	chmod 744 $(STOW)


install: prepare $(PKGS) clean


$(CMDS): %: config-% clean
	@echo Done

$(PKGS):
	@echo Installing $(@)
	$(STOW) $(STOW_ARGS) $(@)

clean:
	@echo Remove all dead symlinks
	# find -L $(HOME) -type l -delete 2>>/dev/null || echo
	find $(HOME) -type l ! -exec test -e {} \; -delete


help: main
