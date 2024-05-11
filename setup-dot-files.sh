#!/usr/bin/env bash

config_dir="/home/david/.config"
source_dir="/home/david/Documents/.dotfiles/dotfiles"

for file in "$source_dir"/*; do
    filename=$(basename "$file")
    if [ ! -L "$config_dir/$filename" ]; then
	echo "Symlinking to $config_dir/$filename"
	ln -s "$file" "$config_dir/$filename"
    else
	echo "Symlink Exists, Ignoring"
    fi
done
