# MONGODBD is a no-sql database that is used to store data in a JSON-like format.
# It is a popular choice for modern applications because it is easy to adjust
# and scale.

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $curr_dir/utils/platform.sh

utility="MongoDB"
system=$(get_platform)
platform_supported=1

if is_linux; then
  platform_supported=0

  # check if system supports mongodb specifically (should have the word "jammy" or "focal")
  system=$(lsb_release -c | grep -E "jammy|focal")

  if [ "$system" != "" ]; then
      platform_supported=1
  fi
fi

# ==== INSTALLATION

if is_linux && $platform_supported; then
  echo "installing mongodb..."
  apt-get update

  # setup keys
  apt install gnupg curl
  curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

  # install mongodb
  apt install mongodb-org
fi

# ==== CONFIGURATION

if is_linux && $platform_supported; then
  # start mongod service
  systemctl start mongod

  # ensure that mongod starts on boot
  sudo systemctl enable mongod
  
  # if you receive error: Failed to start mongod.service: Unit mongod.service not found.
  # run the following command to fix the error
  #
  # sudo systemctl daemon-reload
fi



# ==== FEEDBACK

if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi