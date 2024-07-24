#!/usr/bin/env bash

# Grab the script name
script_name=$(basename "$0")

# Include files and directories prepended with a dot
shopt -s dotglob

# Sym Link files in current directory to HOME/
for file in *; do
  
  # Skip all directories
  if [[ -d "$file" ]]; then
    continue
  fi

  # If the file is the script, skip
  if [[ "$file" != "$script_name" ]]; then
    
    # Check to see if its a directory and if it already exists
    if [[ ! -e "$HOME/$file" ]]; then
      ln -s "$(pwd)/$file" "$HOME/$file"
    else
      echo "Skipping $HOME/$file already exists."
    fi
  fi
done

# Sym link files and directories in dotfiles to HOME/.config/
for file in dotfiles/*; do
  
  # If the file we are about to create exists, skip this loop
  if [ -e "$HOME/.config/$(basename "$file")" ]; then
    echo "Skipping $HOME/.config/$file already exists."
    continue
  fi

  # Attempt Sym Linking to .config/
  if ln -s "$(pwd)/$file" "$HOME/.config/$(basename $file)"; then
    # If it worked, print success
    echo "Succesfully created sym link at $HOME/.config/$(basename $file)"
  else
    # If it failed, print failure (-e fails if it exists, but is broken)
    echo "Could not create sym link at $HOME/.config/$(basename $file) (broken link?)"
  fi
done

cd
cd .config
git clone git@github.com:Master449/neovim-config.git nvim
