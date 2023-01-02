

has() {
  type "${1:?too few arguments}" &>/dev/null
}


is_login_shell() {
  [[ $SHLVL == 1 ]]
}


is_git_repo() {
  git rev-parse --is-inside-work-tree &>/dev/null
  return $status
}


is_tmux_running() {
  [[ -n $TMUX ]]
}


shell_has_started_interactively() {
  [[ -n $PS1 ]]
}


ostype() {
  echo ${(L):-$(uname)}
}


os_detect() {
  export PLATFORM
  case "$(ostype)" in
    *'linux'*)  PLATFORM='linux'   ;;
    *'darwin'*) PLATFORM='osx'     ;;
    *'bsd'*)    PLATFORM='bsd'     ;;
    *)          PLATFORM='unknown' ;;
  esac
}


is_osx() {
  if [[ "$PLATFORM" == "osx" ]]; then
    return 0
  else
    return 1
  fi
}


is_linux() {
  if [[ "$PLATFORM" == "linux" ]]; then
    return 0
  else
    return 1
  fi
}


is_bsd() {
  if [[ "$PLATFORM" == "bsd" ]]; then
    return 0
  else
    return 1
  fi
}


get_os() {
  local os
  for os in osx linux bsd; do
    if is_$os; then
      echo $os
    fi
  done
}

# vim: ft=sh
