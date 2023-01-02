#!/bin/bash 

check_ufw() {
	if type "ufw" >/dev/null 2>&1; then
		echo 1
	else
		echo 0
	fi
}


if [[ $(check_ufw) -eq 0 ]]; then
	sudo pacman -S ufw
fi

sudo ufw default deny
sudo ufw enable
