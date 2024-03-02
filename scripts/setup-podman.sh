# PODMAN is a containerization platform, like Docker, that packages
# your application and all its dependencies together into software
# packages called containers which can be run on any machine that also
# has Podman installed. Unlike Docker, Podman does not require a
# daemon, with root privileges, to manage containers which mitigates
# security concerns. Apart from that, Podman is compatible with Docker
# and can run Docker containers and images.

curr_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $curr_dir/utils/platform.sh

utility="Podman"
system=$(get_platform)
platform_supported=1

if is_linux || is_mac; then
  platform_supported=0
fi

# ==== INSTALLATION

if is_linux; then
  echo "installing podman..."
  apt update
  sudo apt install podman -y
fi

if is_mac; then
  echo "installing podman..."
  brew install podman
fi

# ==== CONFIGURATION

if is_linux || is_mac; then
  podman machine init
  podman machine start
fi

# ==== FEEDBACK

if [ $platform_supported -eq 0 ]; then
  echo "$utility installed successfully"
fi

if [ $platform_supported -ne 0 ]; then
  echo "$utility is not supported by the Setup Scripts on this system ($system)"
fi
