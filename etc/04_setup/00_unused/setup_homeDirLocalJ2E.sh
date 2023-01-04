#!/usr/bin/bash

if type xdg-user-dirs-gtk-update >/dev/null 2>&1; then
	LANG=C xdg-user-dirs-gtk-update
	reboot

else
	echo "xdg-user-dirs-gtk-update is not exist!!"
	echo "please install it."
	echo
	echo "sudo pacman -S xdg-user-dirs-gtk"
fi

