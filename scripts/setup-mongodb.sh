# check if system supports mongodb (should have the word "jammy" or "focal")
supported=$(lsb_release -c | grep -E "jammy|focal")

# if system is not supported, exit
if [ "$supported" = "" ]; then
    echo "This script only supports Ubuntu 22.04 (Jammy Jellyfish) and 20.04 (Focal Fossa)"
    exit 1
fi

sudo apt-get install gnupg curl

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo systemctl start mongod

# if you receive error: Failed to start mongod.service: Unit mongod.service not found.
# run the following command to fix the error
#
# sudo systemctl daemon-reload

# check that mongod is running
sudo systemctl status mongod

# start mongod on boot
sudo systemctl enable mongod

# prompt user
echo "MongoDB installed successfully"
echo "To start MongoDB, run: mongosh"

