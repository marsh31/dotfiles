#!/usr/bin/bash
# 
# NAME:   rust_installer.sh
# AUTHOR: marsh
# 
# NOTE:
#
# 	install rust and other tools.
# tools:
# 
# if you want to uninstall rust, then do below cmd.
# `rustup self uninstall`
#


install_rust() {
  echo "[INFO] installing rust..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_cargo_tools() {
  export CARGO_NET_FETCH_WITH_CLI=true
  echo "[INFO] installing rust tools..."
  echo 

  echo "[INFO] installing cargo-watch..."
  cargo install cargo-watch

  echo "[INFO] installing cargo-generate..."
  cargo install cargo-generate

  echo "[INFO] installing cargo-update..."
  cargo install cargo-update

  echo "[INFO] installing cargo-tree..."
  cargo install cargo-tree

  echo "[INFO] installing cargo-graph..."
  cargo install cargo-graph

  echo "[INFO] installing cargo-benchcmp..."
  cargo install cargo-benchcmp

  echo "[INFO] installing cargo-make..."
  cargo install cargo-make

  echo "[INFO] installing wasm-pack..."
  cargo install wasm-pack

  echo "[INFO] installing rust-analyzer..."
  rustup component add rls rust-analysis rust-src
  sudo pacman -S rust-analyzer

}

install_wasm_pack() {
  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
}

install_rustup() {
  echo "[INFO] installing env..."
	rustup target add wasm32-unknown-unknown

  read -n1 -p "change default (stable) to nightly? (Y/n): " yn
  echo 
  if [[ $yn = [yY] ]]; then
    rustup install nightly
    rustup default nightly
  fi
}

main() {
	install_rust

  echo "[INFO] read env for rust"
  source $HOME/.cargo/env

  install_wasm_pack
  
	install_rustup

	install_cargo_tools
}


main
