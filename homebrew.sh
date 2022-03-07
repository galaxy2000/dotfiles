#!/bin/bash

function setting_mirror_source() {
  local tsinghua_mirrors="https://mirrors.tuna.tsinghua.edu.cn"
  local brew_bottles="export HOMEBREW_BOTTLE_DOMAIN=\"$tsinghua_mirrors/homebrew-bottles\""
  local brew_git="export HOMEBREW_BREW_GIT_REMOTE=\"$tsinghua_mirrors/git/homebrew/brew.git\""
  local brew_core_git="export HOMEBREW_CORE_GIT_REMOTE=\"$tsinghua_mirrors/git/homebrew/homebrew-core.git\""
  if [[ $1 == "export_shell_env" ]]; then
    eval "$brew_git"
    eval "$brew_core_git"
    eval "$brew_bottles"
  else
    test -r "$1" && echo -e "$brew_git\n$brew_core_git\n$brew_bottles" >>"$1"
  fi
}

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  echo "Installing Homebrew"
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # init mirror sources
  setting_mirror_source "export_shell_env"
  #
  git clone --depth=1 "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git" brew-install
  /bin/bash brew-install/install.sh
  rm -rf brew-install
fi

# Check whether installed.
[[ ! "$(type -P brew)" ]] && echo "Homebrew failed to install." && return 1

# Init shell env
zprofile="$HOME/.zprofile"
if [[ ! -f "$zprofile" ]]; then
  echo "touch .zprofile $HOME/.zprofile"
  touch "$zprofile"
fi
if [ $(grep -c "/bin/brew shellenv" "$zprofile") -eq 0 ]; then
  echo "Setting Homebrew mirrors sources to $HOME/.zprofile"
  setting_mirror_source "$zprofile"
  test -r "$zprofile" && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>"$zprofile"
fi

# Updating Homebrew
echo "Updating Homebrew..."
brew doctor
brew update

# Install formulas
formulas=(
  aria2
  asdf
  autoconf
  autojump
  automake
  bat
  brew-cask-completion
  ca-certificates
  cmake
  fd
  fzf
  git
  git-extras
  hyperkit
  highlight
  kubernetes-cli
  minikube
  mmv
  ohcount
  ripgrep
  squirrel
  stow
  tldr
  tmux
  tree
  wget
  xz
  zstd
)

casks=(
  android-platform-tools
  appcleaner
  caffeine
  cheatsheet
  docker
  dozer
  gas-mask
  go2shell
  iterm2
  macvim
  mos
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  qlvideo
  quicklook-json
  quicknfo
  quicklookase
  suspicious-package
  webpquicklook
  jietu
  typora
  visual-studio-code
)

function getDiff() {
  left=$1
  right=$2
  local diff_result=()
  for item in ${left[*]}; do
    if [[ ! ${right[*]} =~ ${item} ]]; then
      diff_result=("${diff_result[@]}" "$item")
    fi
  done
  [[ "$left" ]] && echo "${diff_result[@]}"
}

function brew_install_formulas() {
  formulas=($(getDiff "${formulas[*]}" "$(brew list --formula -1)"))
  echo "Installing Homebrew formulas: ${formulas[*]}"
  if [ ${#formulas[@]} -gt 0 ]; then
    for formula in "${formulas[@]}"; do
      echo "-----------------------------------------------"
      echo "brew install ${formula}"
      echo "-----------------------------------------------"
      brew install "$formula"
    done
  fi
}

function brew_install_casks() {
  casks=($(getDiff "${casks[*]}" "$(brew list --casks -1)"))
  echo "Installing Homebrew casks: ${casks[*]}"
  if [ ${#casks[@]} -gt 0 ]; then
    for cask in "${casks[@]}"; do
      echo "-----------------------------------------------"
      echo "brew install --cask ${cask}"
      echo "-----------------------------------------------"
      brew install --cask "$cask"
    done
  fi
}

function brew_cleanup() {
  echo "-----------------------------------------------"
  echo "brew cleanup ...."
  echo "-----------------------------------------------"
  brew cleanup
}

brew_install_formulas
brew_install_casks
brew_cleanup
