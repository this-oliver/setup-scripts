# DOCKER is a containerization platform that packages your application
# and all its dependencies together into software packages called
# containers which can be run on any machine that also has Docker installed.

curr_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $curr_dir/utils/platform.sh

utility="Docker"
system=$(get_platform)
platform_supported=1

if is_linux || is_mac; then
  platform_supported=0
fi

# ==== INSTALLATION

if is_linux; then
  echo "installing docker..."
  # Uninstall conflicting scripts
  for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

  # Add Docker's official GPG key:
  sudo apt install ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

  update_package_manager 'force'

  # Install latest docker version
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

if is_mac; then
  echo "installing docker..."
  softwareupdate --install-rosetta

  # install docker desktop (docker is only available via docker desktop)
  curl https://desktop.docker.com/mac/main/arm64/Docker.dmg --output Docker.dmg
  sudo hdiutil attach Docker.dmg
  sudo Volumes/Docker/Docker.app/Contents/MacOS/install
  sudo hdiutil detach /Volumes/Docker
fi

# ==== FEEDBACK

if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi