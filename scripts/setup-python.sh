# PYTHON is a popular programming language. Python3 is the latest
# version of the language. It is accompanied by pip3 which is a package
# manager that allows you to install and manage libraries and frameworks
# for your Python projects.

# ==== INSTALLATION

echo "installing python..."
apt install python3 python3-pip

# ==== CONFIGURATION

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

# ==== FEEDBACK

echo "python installed successfully"