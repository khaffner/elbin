# Assumes:
#   The hostname should be elbin 
#   The username is pi
#   The host is a Raspberry Pi 3B
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
# https://devdojo.com/bobbyiliev/how-to-install-docker-and-docker-compose-on-raspberry-pi
apt-get install libffi-dev libssl-dev -y
apt install python3-dev -y
apt-get install python3 python3-pip -y
pip3 install docker-compose
usermod -aG docker pi

# Host settings
raspi-config nonint do_hostname "elbin"
raspi-config nonint do_i2c 0  # 0 should enable it

# Clone this repo
git clone https://github.com/khaffner/elbin.git /home/pi/elbin
chown -R pi:pi /home/pi/elbin/

# Folders for containers
mkdir /can-data
chown -R pi:pi /can-data/

mkdir /homeassistant-config
chown -R pi:pi /homeassistant-config/

mkdir /portainer-data
chown -R pi:pi /portainer-data/

echo ############################
echo ###### Please reboot #######
echo ############################