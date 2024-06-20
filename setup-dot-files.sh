#!/usr/bin/env bash

# Grab the script name
script_name=$(basename "$0")

# Include files and directories prepended with a dot
shopt -s dotglob

# Sym Link files in current directory to HOME/
for file in *; do
  
  # If the file is the script, skip
  if [[ "$file" != "$script_name" ]]; then
    
    # Check to see if its a directory and if it already exists
    if [[ ! -d "$file" && ! -e "$HOME/$file" ]]; then
      ln -s "$(pwd)/$file" "$HOME/$file"

      # Don't print the skip if this is a directory
    elif [[ ! -d "$file" ]]; then
      echo "Skipping $HOME/$file already exists."
    fi
  fi
done

# Sym link files and directories in dotfiles to HOME/.config/
for file in dotfiles/*; do
  
  # If the file we are about to create exists, skip
  if [ -e "$HOME/.config/$(basename "$file")" ]; then
    echo "Skipping $HOME/.config/$file already exists."
  else

    # Attempt Sym Linking to .config/
    if ln -s "$(pwd)/$file" "$HOME/.config/$(basename $file)"; then

      # If it worked, print success
      echo "Succesfully created sym link at $HOME/.config/$(basename $file)"
    else

      # If it failed, print failure (-e fails if it exists, but is broken)
      echo "Could not create sym link at $HOME/.config/$(basename $file) (broken link?)"
    fi
  fi
done
