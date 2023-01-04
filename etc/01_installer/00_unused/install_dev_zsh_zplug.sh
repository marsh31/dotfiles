#!/usr/bin/env bash

main() {
  if type git >/dev/null 2>&1; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  fi
}

main $@
