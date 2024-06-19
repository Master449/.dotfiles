#!/usr/bin/env bash

script_name=$(basename "$0")

shopt -s dotglob

for file in *; do
  if [[ "$file" != "$script_name" && ! -d "$file" ]]; then
    ln -s "$(pwd)/$file" "$HOME/$file"
  fi
done

for file in dotfiles/*; do
  target="$HOME/.config/$(basename "$file")"
  if [ -e "$target" ]; then
    echo "Skipping $file, $target already exists."
  else
    ln -s "$(pwd)/$file" "$target"
  fi
done
#for file in "$source_dir"/*; do
#    filename=$(basename "$file")
#    if [ ! -L "$config_dir/$filename" ]; then
#	echo "Symlinking to $config_dir/$filename"
#	ln -s "$file" "$config_dir/$filename"
#    else
#	echo "Symlink Exists, Ignoring"
#    fi
#done
