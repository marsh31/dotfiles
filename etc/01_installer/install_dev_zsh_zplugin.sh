#!/usr/bin/env bash

main() {
  if type git >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
  fi
}

main $@
