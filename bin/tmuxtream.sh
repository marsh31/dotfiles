#!/usr/bin/env bash

_PROGNAME=(basename $0)
_VERSION="0.0.1"


# MARK: - init utils {{{1
set_color() {
  # color
  readonly BLACK="\033[30m"
  readonly RED="\033[31m"
  readonly GREEN="\033[32m"
  readonly YELLOW="\033[33m"
  readonly BLUE="\033[34m"
  readonly MAGENTA="\033[35m"
  readonly CYAN="\033[36m"
  readonly WHITE="\033[37m"

  # attr
  readonly BOLD="\033[1m"
  readonly DEFAULT="\033[0m"
}

set_filter() {
  local filters="fzf"

  while [[ -n $filters ]]; do
    filter=${filters%%:*}

    if type "$filter" >/dev/null 2>&1; then
      [[ "$filter" = "fzf" ]] && filter=($filter +m --cycle --reverse --ansi --prompt=tmux\ \>\ )
      [[ "$filter" = "fzf-tmux" ]] && filter=($filter -r --ansi --prompt=tmux\ \>\ )
      
      return 0
    else
      filters="${filters#*:}"

    fi
  done
}



# MARK: - Usage {{{1
usage() {
cat << EOF >&2
Usage: $_PROGNAME [option]

options:
  -s              Kill Session operation.
  -w              Kill Window operation.
  -h, --help      Show help.
  -v, --version   Show version.
EOF
}


# MARK: - Operation {{{1
# Operation and list:
# - main
#   - operation  ok
#   - list       ok
#
# - killsession
#   - operation  ok
#   - list       ok
# 
# - killwindow
#   - operation  ok
#   - list       ok

# MARK: - main::operation {{{2
main::operation() {
  ans=$(main::list | "${filter[@]}")

  case "$ans" in
    *New\ Session*)
      if [[ -n "$TMUX" ]]; then
        tmux detach-client
      fi
      tmux new-session -Ad
      ;;

    *New\ Window*)
      tmux new-window
      ;;

    "Kill Sessions")
      killsession::operation
      ;;

    "Kill Windows")
      killwindow::operation
      ;;

    *Switch*)
      tmux select-window -t $(echo "$ans" | awk '{print $4}' | sed "s/://g")
      ;;

    *Attach*)
      tmux attach -t $(echo "$ans" | awk '{print $4}' | sed "s/://")
      ;;

    *Detach*)
      tmux detach-client
      ;;

    *quit*)
      exit 0
      ;;
  esac
}

# MARK: - main::list {{{2
main::list() {
  if [[ -z "$TMUX" ]]; then
    echo -e "${GREEN}Attach${DEFAULT} ==> [ ${BLUE}New Session${DEFAULT} ]"
    tmux list-session 2>/dev/null | while read line; do
      [[ ! "$line" =~ "attached" ]] || line="${GREEN}$line${DEFAULT}"
      echo -e "${GREEM}Attach${DEFAULT} ==> [ $line ]"
    done

  else
    echo -e "${GREEN}Switch${DEFAULT} ==> [ ${BLUE}New Session${DEFAULT} ]"
    tmux list-session 2>/dev/null | while read line; do
      [[ ! "$line" =~ "attached" ]] || line="${GREEN}$line${DEFAULT}"
      echo -e "${GREEN}Switch${DEFAULT} ==> [ $line ]"
    done

    echo -e "${CYAN}Switch${DEFAULT} ==> [ ${BLUE}New Window${DEFAULT} ]"
    tmux list-window | sed "/active/d" | while read line; do
      echo -e "${CYAN}Switch${DEFAULT} ==> [ $(echo $line | awk '{ print $1 " " $2 " " $3 " " $4 " " $5 }') ]"
    done

    echo -e "${MAGENTA}Detach${DEFAULT}"
    if [[ $(tmux display-message -p '#{session_windows}') -gt 1 ]]; then
      echo -e "${RED}Kill Windows${DEFAULT}"
    fi
  fi

  tmux has-session 2>/dev/null && echo -e "${RED}Kill Sessions${DEFAULT}"
  echo -e "${YELLOW}Quit${DEFAULT}"
}


# MARK: - killsession::operation {{{2
killsession::operation() {
  local ans=$(killsession::list | "${filter[@]}")
  case "$ans" in
    *Kill*Server*)
      tmux kill-server
      main::operation
      ;;

    *kill*windows*)
      tmux kill-session -t $(echo "$ans" | awk '{print $4}' | sed "s/://g")
      tmux has-session 2>/dev/null && killsession::operation || main::operation
      ;;

    "Back")
      main::operation
      ;;

    "Quit")
      exit 0
      ;;
  esac
}


# MARK: - killsession::list {{{2
killsession::list() {
  local list_session=$(tmux list-session 2>/dev/null)
  echo "$list_session" | while read line; do
    [[ "$line" =~ "attached" ]] && line="${GREEN}$line${DEFAULT}"
    echo -e "${RED}Kill${DEFAULT} ==> [ $line ]"
  done

  [[ $(echo "$list_session" | grep -c '') = 1 ]] || echo -e "${RED}Kill${DEFAULT} ==> [ ${RED}Server${DEFAULT} ]"
  echo -e "${BLUE}Back${DEFAULT}"
  echo -e "${YELLOW}Quit${DEFAULT}"
}


# MARK: - killwindow::operation {{{2
killwindow::operation() {
  if (( $(tmux display-message -p '#{session_windows}') > 1 )); then
    ans=$(killwindow::list | "${filter[@]}")
    if [[ "$ans" =~ "Kill" ]]; then
      tmux kill-window -t $(echo "$ans" | awk '{print $4}' | sed "s/://g")
      killwindow::operation

    elif [[ "$ans" = "Back" ]]; then
      main::operation

    elif [[ "$ans" = "Quit" ]]; then
      exit 0
    fi

  else
    main::operation
  fi
}

# MARK: - killwindow::list {{{2
killwindow::list() {
  tmux list-windows | while read line; do
    line="$(echo $line | awk '{print $1 " " $2 " " $3 " " $4 " " $5 " " $9}')"
    [[ "$line" =~ "active" ]] && line="${GREEN}$line${DEFAULT}"
    echo -e "${RED}Kill${DEFAULT} ==> [ $line ]"
  done
  echo -e "${BLUE}Back${DEFAULT}"
  echo -e "${YELLOW}Quit${DEFAULT}"
}



# MARK: - main {{{1
main() {
  set_filter
  set_color

  if [[ $# = 0 ]]; then
    main::operation

  elif [[ $# = 1 ]]; then
    case $1 in
      "-s" )
        killsession::operation    
        ;;

      "-w" )
        killwindow::operation
        ;;

      "-h" | "--help" )
        ;;
    
      "-v" | "--version")
        ;;

    esac

  else
    echo -e "${RED}ERROR: ${DEFAULT}Set option is only one." 1>&2 && exit 1

  fi
}

main $@
