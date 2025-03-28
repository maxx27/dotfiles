#!/bin/bash
set -x -e

# UNFINISHED

# Steps to build and install ripgrep from source on Ubuntu.
sudo apt-get -y install cargo
[ ! -e ripgrep ] && git clone https://github.com/BurntSushi/ripgrep
cd ripgrep

# workaroung for the error:
#   attempted ssh-agent authentication, but none of the usernames `git` succeeded
# https://github.com/rust-lang/cargo/issues/3381
# eval `ssh-agent -s`
# ssh-add
# cargo ...

cargo build --release
cargo test --all

