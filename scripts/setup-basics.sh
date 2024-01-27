# update
sudo apt update

# install basic tools
sudo apt install curl git bat nmap -y

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
