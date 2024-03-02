# ZSH is a shell designed for interactive use. OH-MY-ZSH 
# is a framework for managing zsh configuration. It comes 
# with a lot of plugins and themes.

# ==== INSTALLATION

# capture theme name in first argument
theme=$1

# install zsh
echo "installing oh-my-zsh..."
apt update
apt install zsh

# make zsh default shell
chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ==== CONFIGURATION

# if theme is provided, set theme
if [ "$theme" != "" ]; then
    sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"$theme\"/g" ~/.zshrc
fi

# set auto suggestion and syntax highlighting plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==== FEEDBACK

echo "Oh-my-zsh installed successfully (restart terminal to see changes)"