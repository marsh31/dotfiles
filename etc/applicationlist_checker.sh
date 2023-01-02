#!/usr/bin/bash

script_path="$(cd $(dirname $0); pwd)/applicationlist.txt"
while read line
do
	if type "$line" >/dev/null 2>&1; then
		echo "$line exist."
	else
		echo "$line is not exist."
	fi
done < $script_path

