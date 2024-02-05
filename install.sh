# function that checks if response is valid (Y/n)
function check_response {
    if [ "$1" = "Y" ] || [ "$1" = "y" ] || [ "$1" = "N" ] || [ "$1" = "n" ] || [ "$1" = "" ]; then
        return 0
    else
        return 1
    fi
}

# function that checks if version number is valid
function check_version {
    if [[ "$1" =~ ^[0-9]+(\.[0-9]+)*$ ]]; then
        return 0
    else
        return 1
    fi
}

# function that checks if oh-my-zsh theme is valid-ish
function check_theme {
  # lowercase letters, numbers, hyphens and + are allowed
    if [[ "$1" =~ ^[a-z0-9-+]*$ ]]; then
        return 0
    else
        return 1
    fi
}

# ========= GET USER INPUT =========

# ask user if they want to install oh-my-zsh
read -p "Do you want to install oh-my-zsh? (Y/n): " install_oh_my_zsh

# throw error if response is invalid
if ! check_response $install_oh_my_zsh; then
    echo "Invalid response: $install_oh_my_zsh"
    exit 1
fi

if [ "$install_oh_my_zsh" = "Y" ] || [ "$install_oh_my_zsh" = "y" ] || [ "$install_oh_my_zsh" = "" ]; then
    # ask user if they want to set theme
    read -p "Do you want to set a theme for oh-my-zsh? (Y/n): " set_theme

    # throw error if response is invalid
    if ! check_response $set_theme; then
        echo "Invalid response: $set_theme"
        exit 1
    fi

    # if user wants to set theme, ask for theme name
    if [ "$set_theme" = "Y" ] || [ "$set_theme" = "y" ] || [ "$set_theme" = "" ]; then
        read -p "Which theme do you want to set? (leave blank for default): " theme

        # throw error if theme is invalid and not blank
        if ! check_theme $theme; then
            if ! [ "$theme" = "" ]; then
                echo "Invalid theme name: $theme"
                exit 1
            fi
        fi
    fi
fi

# ask user if they want to install docker
read -p "Do you want to install docker? (Y/n): " install_docker

# throw error if response is invalid
if ! check_response $install_docker; then
    echo "Invalid response: $install_docker"
    exit 1
fi

# ask user if they want to install nodejs
read -p "Do you want to install nodejs? (Y/n): " install_nodejs

# throw error if response is invalid
if ! check_response $install_nodejs; then
    echo "Invalid response: $install_nodejs"
    exit 1
fi

# if user wants to install nodejs, ask for version
if [ "$install_nodejs" = "Y" ] || [ "$install_nodejs" = "y" ] || [ "$install_nodejs" = "" ]; then
    read -p "Which version of nodejs do you want to install? (leave blank for latest): " node_version

    # throw error if version is invalid and not blank
    if ! check_version $node_version; then
        if ! [ "$node_version" = "" ]; then
            echo "Invalid version number: $node_version"
            exit 1
        fi
    fi
fi

# ask user if they want to install python
read -p "Do you want to install python? (Y/n): " install_python

# throw error if response is invalid
if ! check_response $install_python; then
    echo "Invalid response: $install_python"
    exit 1
fi

# ========= RUN INSTALL SCRIPTS =========

# get path to script directory
curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scripts_dir="$curr_dir/scripts"

# update apt
echo "Updating apt..."
sudo apt update

# run basic install script
echo "Running basic install script..."
bash $scripts_dir/setup-basics.sh

# run docker install script
if [ "$install_docker" = "Y" ] || [ "$install_docker" = "y" ] || [ "$install_docker" = "" ]; then
    echo "Running docker install script..."
    bash $scripts_dir/setup-docker-engine.sh
fi

# run nodejs install script (note: setup-nodejs script takes nodejs version as argument)
if [ "$install_nodejs" = "Y" ] || [ "$install_nodejs" = "y" ] || [ "$install_nodejs" = "" ]; then
    echo "Running nodejs install script..."
    bash $scripts_dir/setup-nodejs.sh $node_version
fi

# run python install script
if [ "$install_python" = "Y" ] || [ "$install_python" = "y" ] || [ "$install_python" = "" ]; then
    echo "Running python install script..."
    bash $scripts_dir/setup-python.sh
fi

# run oh-my-zsh install script
if [ "$install_oh_my_zsh" = "Y" ] || [ "$install_oh_my_zsh" = "y" ] || [ "$install_oh_my_zsh" = "" ]; then
    echo "Running oh-my-zsh install script..."
    bash $scripts_dir/setup-oh-my-zsh.sh $theme
fi