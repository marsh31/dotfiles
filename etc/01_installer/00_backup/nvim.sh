#!/bin/bash

dotdir_root=~/dotfiles
dotcfg_root=${dotdir_root}/.config
config_root=~/.config
config_name=nvim


setup_other() {
	# setup plugin manager jetpack

	echo "install vim jetpack"
	${dotdir_root}/etc/install/vim_jetpack.sh
}



if [[ ! -d ${config}/${config_name} ]]; then
	echo "linked config dir"
	ln -s ${dotcfg_root}/${config_name} ${config_root}/${config_name}

	echo "other setup"
	setup_other

else
	echo "Config dir is exist."
fi

