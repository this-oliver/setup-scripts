setup-basics=./setup-basics.sh
setup-ohh-my-zsh=./setup-ohh-my-zsh.sh
setup-docker=./setup-docker-engine.sh
setup-nodejs=./setup-node.sh

# ask user if they want to install docker
echo "Do you want to install docker? (Y/n)"
read install_docker

# ask user if they want to install oh-my-zsh
echo "Do you want to install oh-my-zsh? (Y/n)"
read install_oh_my_zsh

# ask user if they want to install nodejs
echo "Do you want to install nodejs? (Y/n)"
read install_nodejs

# update apt
echo "Updating apt..."
sudo apt update

# if user wants to install nodejs, ask for version
if [ "$install_nodejs" = "Y" ] || [ "$install_nodejs" = "y" ] || [ "$install_nodejs" = "" ]; then
    echo "Which version of nodejs do you want to install? (leave blank for latest)"
    read node_version
fi

# run basic install script
echo "Running basic install script..."
chmod +x $setup-basics
./$setup-basics

# run docker install script
if [ "$install_docker" = "Y" ] || [ "$install_docker" = "y" ] || [ "$install_docker" = "" ]; then
    echo "Running docker install script..."
    chmod +x $setup-docker
    ./$setup-docker
fi

# run oh-my-zsh install script
if [ "$install_oh_my_zsh" = "Y" ] || [ "$install_oh_my_zsh" = "y" ] || [ "$install_oh_my_zsh" = "" ]; then
    echo "Running oh-my-zsh install script..."
    chmod +x $setup-ohh-my-zsh
    ./$setup-ohh-my-zsh
fi

# run nodejs install script (note: setup-nodejs script takes nodejs version as argument)
if [ "$install_nodejs" = "Y" ] || [ "$install_nodejs" = "y" ] || [ "$install_nodejs" = "" ]; then
    echo "Running nodejs install script..."
    chmod +x $setup-nodejs
    ./$setup-nodejs $node_version
fi