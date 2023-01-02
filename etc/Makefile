DOTPAHT    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))


print:
	@echo "please make `env`"
	@echo "env list:"
	@echo "  archlinux"

all:


archlinux:
	~/dotfiles/tools/setup_archlinux.sh


list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)


deploy:
	@echo "Create symbolic link to home."
	@echo "==> Start to deploy dotfiles to home directory."
	@echo ""
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)


init:
	@DOTPAHT=$(DOTPAHT) bash $(DOTPAHT)/etc/init/init.sh


update:
	# git pull origin master


install: update deploy init
	@exec $$SHELL


clean: 
	@echo 'Remove dot files in home directory'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)


