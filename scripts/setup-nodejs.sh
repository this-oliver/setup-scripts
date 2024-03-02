# JAVASCRIPT is a popular programming language used for web development.
# NODEJS is a JavaScript runtime built on Chrome's V8 JavaScript engine
# which allows you to run JavaScript programs. It is accompanied by npm
# (Node Package Manager) which is a package manager that allows you to
# install and manage libraries and frameworks for your Nodejs projects.

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $curr_dir/utils/platform.sh

# ==== INSTALLATION

# read argument for nodejs version
node_version=$1

echo "installing nodejs..."

# if no version is provided, install latest
if [ "$node_version" = "" ]; then
    apt install nodejs npm -y
fi

# if version is provided, install that version
if [ "$node_version" != "" ]; then
    curl -fsSL https://deb.nodesource.com/setup_$node_version | sudo -E bash -
    apt-get install -y nodejs
fi

# install pnpm globally
npm install -g pnpm

# ==== CONFIGURATION


# ==== FEEDBACK

echo "nodejs (+npm +pnpm) installed successfully"