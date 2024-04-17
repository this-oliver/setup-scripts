#!/usr/bin/env bash

UPDATED=1

# returns the current platform
function get_platform() {
  name=$(uname)

  if [ "$name" = "Darwin" ]; then
    echo "macos"
  elif [ "$name" = "Linux" ]; then
    echo "linux"
  else
    echo "unknown"
  fi
}

# returns true if the current platform is macOS
function is_macos() {
  if [ "$(uname)" = "Darwin" ]; then
    return 0
  else
    return 1
  fi
}

# returns true if the current platform is linux
function is_linux() {
  if [ "$(uname)" = "Linux" ]; then
    return 0
  else
    return 1
  fi
}

# updates the package manager
function update_package_manager() {
  arg=$1

  # if arg is equal to 'force', then update the package manager
  if [ "$arg" = "force" ]; then
    UPDATED=1
  fi
  
  if is_macos; then
    brew update
  fi

  if is_linux; then
    sudo apt update
  fi

  UPDATED=0
}

function reset_update_flag() {
  UPDATED=1
}

# installs a package using the appropriate package manager
#function install_package() {
#  package=$1

#  # update package manager if not already updated
#  if [ $UPDATED -eq 1 ]; then
#    update_package_manager
#  fi

#  if is_macos; then
#    brew install $package
#  fi

#  if is_linux; then
#    sudo apt install $package -y
#  fi
#}

# returns true if zsh is installed
function is_zsh_installed() {
  if [ -n "$(command -v zsh)" ]; then
    return 0
  else
    return 1
  fi
}

# adds an argument to the bashrc or zshrc file
function set_run_command() {
  arg=$1

  # find if zsh is installed
  if is_zsh_installed; then
    echo "$arg" >>~/.zshrc
    source ~/.zshrc
  else
    echo "$arg" >>~/.bashrc
    source ~/.bashrc
  fi
}