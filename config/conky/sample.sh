#!/usr/bin/bash

script_cmd="conky -c"
script_file="/home/marsh/.config/conky/conky_main"

search="$script_cmd $script_file"

while :
do

  result="$(ps aux | grep "$search" | grep -c ' conky ')"
  if [[ $result -eq "2" ]]; then
    :

  elif [[ $result -eq "1" ]]; then
    echo ${result}
    conky -c $script_file

  else
    echo "Error"
    exit 1
  fi

  sleep 1
done
