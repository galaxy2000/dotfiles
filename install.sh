#!/bin/bash

# Install xcode CLT.
if [[ ! "$(type -P 'xcode-select')" ]]; then
  echo "Installing xcode-select"
  true | xcode-select --install
fi

if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
  sudo xcode-select -switch /Library/Developer/CommandLineTools
fi

# Install tools
source ./homebrew.sh

# Install zsh and oh-my-zsh
if [[ "$(type -P omz)" ]]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  omz update
fi

# Install dotfiles config
function install_dotfiles() {
  local exInclude=(
    iterm
  )
  dotfiles=($(ls -l | grep -e ^d | awk '{print $NF}'))
  echo "dotfiles is: ${dotfiles[*]}"
  for dotfile in ${dotfiles[*]}; do
    if [[ ${exInclude[*]} =~ ${dotfile} ]]; then
      echo "skip exInclude dotfile: $dotfile"
    else
      echo "init dotfiles: $dotfile"
      stow -t "$HOME" "$dotfile"
    fi
  done
}

if [[ "$(type -P stow)" ]]; then
  install_dotfiles
fi

# Update vim plugin
if [[ "$(type -P vim)" ]]; then
  vim +PlugUpgrade +PlugUpdate +qall
fi
