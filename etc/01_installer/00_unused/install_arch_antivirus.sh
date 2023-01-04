#!/bin/bash


if type freshclam >/dev/null 2>&1; then
	sudo freshclam

	sudo systemctl enable --now clamav-daemon
	sudo systemctl enable --now clamav-freshclam
else
	sudo pacman -S clamav
	sudo freshclam

	sudo systemctl enable --now clamav-daemon
	sudo systemctl enable --now clamav-freshclam
fi

