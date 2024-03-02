# PYTHON is a popular programming language. Python3 is the latest
# version of the language. It is accompanied by pip3 which is a package
# manager that allows you to install and manage libraries and frameworks
# for your Python projects.

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $curr_dir/utils/platform.sh

utility="Python"
system=$(get_platform)
platform_supported=1

if is_linux; then
  platform_supported=0
fi

# ==== INSTALLATION

if is_linux; then
  echo "installing python..."
  sudo apt install python3 python3-pip
fi

# ==== CONFIGURATION

if is_linux; then
  # set python and pip as aliases for python3 and pip3
  set_run_command "python=python3"
  set_run_command "pip=pip3"
fi

# ==== FEEDBACK

if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi
