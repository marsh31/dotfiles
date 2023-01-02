#!/usr/bin/env bash

set -euCo pipefail


declare -Ar menu=(
  ['Logout']='i3-msg exit'
  ['PowerOff']='systemctl poweroff'
  ['Reboot']='systemctl reboot'
  ['Lock']='systemctl suspend'
)


print_keys() {
  local -r IFS=$'\n'
  echo "${!menu[*]}"
}

main() {
  local -r yes='yes' no='no'

  if [[ $# -eq 0 ]]; then
    print_keys

  elif [[ $# -eq 1 ]]; then
    echo $1 ${yes}
    echo $1 ${no}

  elif [[ $2 == ${yes} ]]; then
    eval "${menu[$1]}"

  elif [[ $2 == ${no} ]]; then
    print_keys
    
  fi
}

main $@
