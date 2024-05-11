#!/usr/bin/env bash

config_dir="/home/david/.config"
source_dir="/home/david/Documents/.dotfiles/nixos/dotfiles"

for file in "$source_dir"/*; do
    filename=$(basename "$file")
    ln -s "$file" "$config_dir/$filename"
done
