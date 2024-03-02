
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