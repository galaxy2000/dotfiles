#!/bin/bash

# Install xcode CLT.
if [[ ! "$(type -P 'xcode-select')" ]]; then
  echo "Installing xcode-select"
  true| xcode-select --install
fi

if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
  sudo xcode-select -switch /Library/Developer/CommandLineTools
fi


