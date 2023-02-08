#!/bin/bash
# 
# NAME:   install_dev_st.sh
# AUTHOR: marsh
# NOTE:
#
#   install st.

patchfiles=( https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff
	)
src_config=~/dotfiles/etc/01_installer/config.def.h

download_st() {
	git clone https://github.com/Shourai/st.git
	cd st
}


install_st() {
	echo "install st..."
	echo "give me sudo"
	sudo make clean install
}


clean_st() {
	cd ..
	rm -Rf st
}


patch_st() {
	for file in ${patchfiles[@]}; do
		echo "wget $file"
		wget $file
		
		echo "patch -i ${file##*/}"
		patch -i ${file##*/}
	done
}


copy_st_config() {
	echo "copy config file..."
	cp ${src_config} .
}


main() {
	download_st
	# patch_st
	copy_st_config
	
	install_st

	read -n1 -p "clear st repo? (Y/n): " yn
	if [[ $yn = [yY] ]]; then
		clean_st
	else
		echo "bye!!"
	fi
}



if ! command -v git &> /dev/null; then
	echo "git could not be found"
	exit
fi


if ! command -v patch &> /dev/null; then
	echo "patch could not be found"
	exit
fi


if ! command -v wget &> /dev/null; then
	echo "wget could not be found"
	exit
fi


main

