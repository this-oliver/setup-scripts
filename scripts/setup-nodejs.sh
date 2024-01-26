echo "installing nodejs..."

# read argument for nodejs version
node_version=$1

# if no version is provided, install latest
if [ "$node_version" = "" ]; then
    sudo apt install nodejs npm -y
fi

# if version is provided, install that version
if [ "$node_version" != "" ]; then
    curl -fsSL https://deb.nodesource.com/setup_$node_version | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# install pnpm globally
npm install -g pnpm

echo "nodejs (+npm +pnpm) installed successfully"