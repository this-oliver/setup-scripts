# JAVASCRIPT is a popular programming language used for web development.
# NODEJS is a JavaScript runtime built on Chrome's V8 JavaScript engine
# which allows you to run JavaScript programs. It is accompanied by npm
# (Node Package Manager) which is a package manager that allows you to
# install and manage libraries and frameworks for your Nodejs projects.

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $curr_dir/utils/platform.sh

utility="Nodejs"
system=$(get_platform)
platform_supported=1

if is_linux || is_mac; then
  platform_supported=0
fi

# ==== INSTALLATION

# read argument for nodejs version
node_version=$1

if is_linux; then
  echo "installing nodejs..."

  # if no version is provided, install latest
  if [ "$node_version" = "" ]; then
      sudo apt install nodejs npm -y
  fi

  # if version is provided, install that version
  if [ "$node_version" != "" ]; then
      curl -fsSL https://deb.nodesource.com/setup_$node_version | sudo -E bash -
      sudo apt install nodejs -y
  fi

  # install pnpm globally
  sudo npm install -g pnpm
fi

if is_mac; then
  echo "installing nodejs..."
  brew install node@$node_version

  # install pnpm globally
  npm install -g pnpm
fi

# ==== FEEDBACK

if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi
