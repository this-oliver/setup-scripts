# This script installs some common tools that are used in development
# environments.
# 
# Below is a short description of each tool:
#   - curl: a command line tool and library for transferring data with URLs
#   - git: a distributed version control system
#   - nmap: a network exploration tool and security / port scanner
#   - bat: a cat clone with syntax highlighting and Git integration

# install basic tools
sudo apt update
sudo apt install curl git nmap bat -y

# check if bat is renamed to batcat
batcat_path=$(which batcat)

# if batcat is found, set alias for batcat
if [ "$batcat_path" != "" ]; then
    # find if zsh is installed
    zsh_path=$(which zsh)

    # set alias for bat (note: some debian based distros use batcat instead of bat)
    if [ "$zsh_path" != "" ]; then
        echo "alias cat=batcat" >> ~/.zshrc
        source ~/.zshrc
    fi

    if [ "$zsh_path" = "" ]; then
        echo "alias cat=batcat" >> ~/.bashrc
        source ~/.bashrc
    fi
fi
