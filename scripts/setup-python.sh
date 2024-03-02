# PYTHON is a popular programming language. Python3 is the latest
# version of the language. It is accompanied by pip3 which is a package
# manager that allows you to install and manage libraries and frameworks
# for your Python projects.

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $curr_dir/utils/platform.sh

# ==== INSTALLATION

echo "installing python..."
apt install python3 python3-pip

# ==== CONFIGURATION

set_run_command "python=python3"
set_run_command "pip=pip3"

# ==== FEEDBACK

echo "python installed successfully"