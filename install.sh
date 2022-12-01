#!/usr/bin/sh

NVIM=~/.config/nvim

# mkdir -p $NVIM/share
mkdir -p $NVIM

stow --restow --target=$NVIM .
