# get path to script directory
curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
script_dir="$curr_dir/scripts"

setup_basics="$script_dir/setup-basics.sh"
setup_oh_my_zsh="$script_dir/setup-oh-my-zsh.sh"
setup_docker_engine="$script_dir/setup-docker-engine.sh"
setup_nodejs="$script_dir/setup-nodejs.sh"
setup_python="$script_dir/setup-python.sh"

# function that checks if response is valid (Y/n)
function check_response {
    if [ "$1" = "Y" ] || [ "$1" = "y" ] || [ "$1" = "N" ] || [ "$1" = "n" ] || [ "$1" = "" ]; then
        return 0
    else
        return 1
    fi
}

# function that checks if response is valid version number
function check_version {
    if [[ "$1" =~ ^[0-9]+(\.[0-9]+)*$ ]]; then
        return 0
    else
        return 1
    fi
}

# ========= GET USER INPUT =========

# ask user if they want to install oh-my-zsh
echo "Do you want to install oh-my-zsh? (Y/n)"
read install_oh_my_zsh

# throw error if response is invalid
if ! check_response $install_oh_my_zsh; then
    echo "Invalid response: $install_oh_my_zsh"
    exit 1
fi

# ask user if they want to install docker
echo "Do you want to install docker? (Y/n)"
read install_docker

# throw error if response is invalid
if ! check_response $install_docker; then
    echo "Invalid response: $install_docker"
    exit 1
fi

# ask user if they want to install nodejs
echo "Do you want to install nodejs? (Y/n)"
read install_nodejs

# throw error if response is invalid
if ! check_response $install_nodejs; then
    echo "Invalid response: $install_nodejs"
    exit 1
fi

# if user wants to install nodejs, ask for version
if [ "$install_nodejs" = "Y" ] || [ "$install_nodejs" = "y" ] || [ "$install_nodejs" = "" ]; then
    echo "Which version of nodejs do you want to install? (leave blank for latest)"
    read node_version

    # throw error if version is invalid and not blank
    if ! check_version $node_version; then
        if ! [ "$node_version" = "" ]; then
            echo "Invalid version number: $node_version"
            exit 1
        fi
    fi
fi

# ask user if they want to install python
echo "Do you want to install python? (Y/n)"
read install_python

# throw error if response is invalid
if ! check_response $install_python; then
    echo "Invalid response: $install_python"
    exit 1
fi

# ========= RUN INSTALL SCRIPTS =========

# update apt
echo "Updating apt..."
sudo apt update

# run basic install script
echo "Running basic install script..."
chmod +x "$setup_basics" && "$setup_basics"

# run oh-my-zsh install script
if [ "$install_oh_my_zsh" = "Y" ] || [ "$install_oh_my_zsh" = "y" ] || [ "$install_oh_my_zsh" = "" ]; then
    echo "Running oh-my-zsh install script..."
    chmod +x "$setup_oh_my_zsh" && "$setup_oh_my_zsh"
fi

# run docker install script
if [ "$install_docker" = "Y" ] || [ "$install_docker" = "y" ] || [ "$install_docker" = "" ]; then
    echo "Running docker install script..."
    chmod +x "$setup_docker_engine" && "$setup_docker_engine"
fi

# run nodejs install script (note: setup-nodejs script takes nodejs version as argument)
if [ "$install_nodejs" = "Y" ] || [ "$install_nodejs" = "y" ] || [ "$install_nodejs" = "" ]; then
    echo "Running nodejs install script..."
    chmod +x "$setup_nodejs" && "$setup_nodejs" $node_version
fi

# run python install script
if [ "$install_python" = "Y" ] || [ "$install_python" = "y" ] || [ "$install_python" = "" ]; then
    echo "Running python install script..."
    chmod +x "$setup_python" && "$setup_python"
fi
