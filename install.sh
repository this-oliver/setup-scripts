# get path to script directory
curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scripts_dir="$curr_dir/scripts"

# get some util functions
source $scripts_dir/utils/checker.sh

echo "
Welcome to the setup script!

\nThe following tools and utilities will be installed (DEFAULT):

  - curl for downloading files
  - git for version control
  - oh-my-zsh (with autosuggestions) for a better terminal experience

\nThe script also offers the following additions (OPTIONAL):

  - docker for containerization
  - podman for security-focused containerization
  - nodejs (with npm and pnpm) for javascript development
  - python (with pip) for python development
  - mongodb for database management

\nYou can choose to install the default utilities or to customize your setup with the optional utilities.\n"

# ask user if they want to customize their setup
read -p "Do you want to customize your setup? (y/N): " customize

if ! check_response $customize; then
    echo "Invalid response: $customize"
    exit 1
fi

# ========= CUSTOMIZE SETUP - go through each utility and ask user if they want to install it =========

if is_yes $customize; then
  # Docker

  read -p "Do you want to install docker? (y/N): " install_docker

  if ! check_response $install_docker; then
      echo "Invalid response: $install_docker"
      exit 1
  fi

  # Podman

  read -p "Do you want to install podman? (y/N): " install_podman

  if ! check_response $install_podman; then
      echo "Invalid response: $install_podman"
      exit 1
  fi

  # Nodejs

  read -p "Do you want to install nodejs? (y/N): " install_nodejs

  if ! check_response $install_nodejs; then
      echo "Invalid response: $install_nodejs"
      exit 1
  fi

  if is_yes $install_nodejs ]; then
      read -p "Which version of nodejs do you want to install? (leave blank for latest): " node_version

      if ! check_version $node_version; then
          if ! [ "$node_version" = "" ]; then
              echo "Invalid version number: $node_version"
              exit 1
          fi
      fi
  fi

  # Python

  read -p "Do you want to install python? (y/N): " install_python

  if ! check_response $install_python; then
      echo "Invalid response: $install_python"
      exit 1
  fi

  # MongoDB

  read -p "Do you want to install mongodb? (y/N): " install_mongodb

  if ! check_response $install_mongodb; then
      echo "Invalid response: $install_mongodb"
      exit 1
  fi

  # oh-my-zsh

  read -p "Do you want to install zsh + oh-my-zsh? (y/N): " install_oh_my_zsh

  # throw error if response is invalid
  if ! check_response $install_oh_my_zsh; then
      echo "Invalid response: $install_oh_my_zsh"
      exit 1
  fi
fi

# ========= INSTALL UTILITIES - go through each utility and install it if user has given permission =========

# run basic install script
echo "\nInstalling utilities..."
bash $scripts_dir/setup-basics.sh

# this if statement blocks the script from running the rest of the install scripts if the
# user doesn't want to customize their setup
if ! is_yes $customize; then
    # reset the update flag
    reset_update_flag

    echo "\nSetup complete!"
    exit 0
fi

if is_yes $install_docker; then
    echo "\nRunning docker install script..."
    bash $scripts_dir/setup-docker-engine.sh
fi

if is_yes $install_podman; then
    echo "\nRunning podman install script..."
    bash $scripts_dir/setup-podman.sh
fi

if is_yes $install_nodejs; then
    echo "\nRunning nodejs install script..."
    bash $scripts_dir/setup-nodejs.sh $node_version
fi

if is_yes $install_python; then
    echo "\nRunning python install script..."
    bash $scripts_dir/setup-python.sh
fi

if is_yes $install_mongodb; then
    echo "\nRunning mongodb install script..."
    bash $scripts_dir/setup-mongodb.sh
fi

if is_yes $install_oh_my_zsh; then
    echo "\nRunning oh-my-zsh install script..."
    bash $scripts_dir/setup-oh-my-zsh.sh $theme
fi

reset_update_flag