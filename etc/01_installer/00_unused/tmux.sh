#!/bin/bash


dotdir_root=~/dotfiles
dotcfg_root=${dotdir_root}
config_root=~/
config_name=.tmux.conf


setup_other() {
  echo "installing tmux plugin manager..."
  ${dotdir_root}/etc/install/tpm_install.sh
}



if [[ ! -d ${config}/${config_name} ]]; then
	echo "linked config file"
	ln -s ${dotcfg_root}/${config_name} ${config_root}/${config_name}

	echo "other setup"
	setup_other

else
	echo "Config dir is exist."
fi

