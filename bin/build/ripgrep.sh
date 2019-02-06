#!/bin/bash
set -x -e

# UNFINISHED

# Steps to build and install ripgrep from source on Ubuntu.
sudo apt-get -y install cargo
[ ! -e ripgrep ] && git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
cargo build --release
cargo test --all

