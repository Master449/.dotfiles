#!/usr/bin/env bash

script_name=$(basename "$0")

shopt -s dotglob

for file in *; do
  if [[ "$file" != "$script_name" ]]; then
    if [[ ! -d "$file" && ! -e "$HOME/$file" ]]; then
      ln -s "$(pwd)/$file" "$HOME/$file"
    elif [[ ! -d "$file" ]]; then
      echo "Skipping $HOME/$file already exists."
    fi
  fi
done

for file in dotfiles/*; do
  if [ -e "$HOME/.config/$(basename "$file")" ]; then
    echo "Skipping $HOME/.config/$file already exists."
  else
    if ln -s "$(pwd)/$file" "$HOME/.config/$(basename $file)"; then
      echo "Succesfully created sym link at $HOME/.config/$(basename $file)"
    else
      echo "Could not create sym link at $HOME/.config/$(basename $file) (broken link?)"
    fi
  fi
done
