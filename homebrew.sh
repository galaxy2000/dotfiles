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
  touch "$zprofile"
fi
setting_mirror_source "$zprofile"
test -r "$zprofile" && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>"$zprofile"

# Updating Homebrew
echo "Updating Homebrew"
brew update

# Install formula
formula=(
  aria2
  asdf
  autoconf
  autojump
  automake
  bat
  brew-cask-completion
  ca-certificates
  cmake
  docker-machine
  docker-machine-driver-hyperkit
  fd
  fzf
  git
  git-extras
  gradle
  highlight
  kubernetes-cli
  macvim
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
  gas-mask
  go2shell
  iterm2
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