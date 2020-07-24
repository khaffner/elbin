# Assumes:
#   The hostname should be elbin 
#   The username is pi
#   The host is a Raspberry Pi
#   The CAN hat is installed
#   Home Assistant will be used as UI for the data
# Run this script with sudo

# Update the system
apt-get update
apt-get upgrade

# Install git, for pulling this repo and updating later
apt-get install git -y

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker pi

# Host settings
raspi-config nonint do_hostname "elbin"
raspi-config nonint do_i2c 0  # 0 should enable it

# Clone this repo
git clone https://github.com/khaffner/elbin.git /home/pi/elbin
chown pi:pi /home/pi/elbin/

# Folders for containers
mkdir /can-data
chown pi:pi /can-data/

mkdir /homeassistant-config
chown pi:pi /homeassistant-config/

mkdir /portainer-data
chown pi:pi /portainer-data/

echo ############################
echo ###### Please reboot #######
echo ############################