echo "installing python..."

# install python3
sudo apt install python3 python3-pip

# find if zsh is installed
zsh_path=$(which zsh)

# if zsh is installed, set python alias in zshrc
if [ "$zsh_path" != "" ]; then
    echo "alias python=python3" >> ~/.zshrc
    echo "alias pip=pip3" >> ~/.zshrc
    source ~/.zshrc
fi

# otherwise, set python alias in bashrc
if [ "$zsh_path" = "" ]; then
    echo "alias python=python3" >> ~/.bashrc
    echo "alias pip=pip3" >> ~/.bashrc
    source ~/.bashrc
fi

echo "python installed successfully"