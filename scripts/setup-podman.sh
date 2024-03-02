# PODMAN is a containerization platform, like Docker, that packages
# your application and all its dependencies together into software
# packages called containers which can be run on any machine that also
# has Podman installed. Unlike Docker, Podman does not require a
# daemon, with root privileges, to manage containers which mitigates
# security concerns. Apart from that, Podman is compatible with Docker
# and can run Docker containers and images.

# ==== INSTALLATION

echo "installing podman..."
apt update
apt install podman -y

# ==== CONFIGURATION

# ==== FEEDBACK

echo "podman installed successfully"