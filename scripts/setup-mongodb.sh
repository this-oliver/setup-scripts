# MONGODBD is a no-sql database that is used to store data in a JSON-like format.
# It is a popular choice for modern applications because it is easy to adjust
# and scale.

# ==== INSTALLATION

# supported is false by default
supported=1

# check if system supports mongodb (should have the word "jammy" or "focal")
system=$(lsb_release -c | grep -E "jammy|focal")

if [ "$system" != "" ]; then
    supported=0
fi

# install keys and setup mongodb
if $supported; then
    echo "installing mongodb..."
    apt-get update

    # setup keys
    apt-get install gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

    # install mongodb
    apt-get install -y mongodb-org
fi

# ==== CONFIGURATION

if $supported; then
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

if $supported; then
    echo "MongoDB installed successfully"
fi

if ! $supported; then
    echo "MongoDB is not supported on this system"
fi
