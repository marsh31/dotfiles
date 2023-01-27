#!/usr/bin/bash
# 
# NAME:   rust_installer.sh
# AUTHOR: marsh
# 
# NOTE:
#
# 	install rust and other tools.
# tools
# 
# if you want to uninstall rust, then do below cmd.
# `rustup self uninstall`
#
# 
# flow:
#   install rustup
#   read env
#   install wasm-pack
#   install env
#   install dev tools
#   install cargo tools


#
# install rustup
#
echo "[INFO] checking rustup..."
if !(type rustup > /dev/null 2>&1); then
  echo "[INFO] installing rustup..."
  curl https://sh.rustup.rs -sSf | sh
fi


#
# read env
#
if [[ -f $HOME/.cargo/env ]]; then
  echo "[INFO] read env for rust"
  source $HOME/.cargo/env
else
  echo "[ERROR] $HOME/.cargo/env is not found."
  echo "[ERROR] rustup is not installed. Please install it."
fi


#
# install wasm-pack
#
echo "[INFO] checking wasm-pack..."
if !(type wasm-pack > /dev/null 2>&1); then
  echo "[INFO] installing wasm-pack..."
  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
fi


#
# install env
#
echo "[INFO] installing env..."
rustup target add wasm32-unknown-unknown
rustup install nightly
rustup default nightly


#
# install dev tools
#
echo "[INFO] installing rust-analyzer..."
if !(type rust-analyzer > /dev/null 2>&1); then
  rustup component add rls rust-analysis rust-src
  sudo pacman -S rust-analyzer
fi


#
# install cargo tool
#
echo "[INFO] ckecking cargo..."
if (type cargo > /dev/null 2>&1); then
  echo "[INFO] ok. install cargo tools"
  echo "[INFO] if you use [url \"github:\"] config in .gitconfig, please down the setting."
  read -n1 -p "plsease push the button. Then enter the ~/.gitconfig file."
  export CARGO_NET_FETCH_WITH_CLI=true
  cargo install cargo-watch
  cargo install cargo-generate
  cargo install cargo-update
  cargo install cargo-tree
  cargo install cargo-graph
  cargo install cargo-benchcmp
  cargo install cargo-make
  cargo install wasm-pack
fi
