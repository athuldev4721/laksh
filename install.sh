
# Install Python dependencies
echo "Installing Python dependencies..."
sleep 2
apt-get install -y git python3-virtualenv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind virtualenv

# Add user 'cowrie' with a disabled password
echo "Adding user 'cowrie'..."
sleep 2
adduser --disabled-password --gecos "" cowrie

# Switch to user 'cowrie' and execute commands
echo "Switching to user 'cowrie'..."
sleep 2
su cowrie <<EOF
cd /home/cowrie

# Clone honeypot
echo "Cloning honeypot repository..."
sleep 2
git clone https://github.com/athuldev4721/laksh_cowrie.git

# Set up virtual environment
cd laksh_cowrie
echo "Setting up virtual environment..."
sleep 2
virtualenv cowrie-env
echo "Activating virtual environment..."
sleep 2
source cowrie-env/bin/activate

# Upgrade pip
echo "Upgrading pip..."
sleep 2
pip install --upgrade pip

# Install Cowrie requirements
echo "Installing Cowrie dependencies..."
sleep 2
pip install --upgrade -r requirements.txt

#copy config file
echo "Copying config file..."
sleep 2
cp etc/cowrie.cfg.dist cowrie.cfg

# Start Cowrie
echo "Starting Cowrie..."
sleep 2
bin/cowrie start

# Start live logs in the background
echo "Setting up live logs..."
sleep 2
tail -f ./var/log/cowrie/cowrie.log &

EOF

echo "Your honeypot environment has successfully started with live logs!"
