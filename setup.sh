# Assumes:
#   The hostname should be elbin 
#   The username is pi
#   The host is a Raspberry Pi 3B
#   The CAN hat is installed
#   Home Assistant will be used as UI for the data
#   GPS receiver is /dev/ttyUSB1
# Run this script with sudo

# Update the system
apt-get update
apt-get upgrade

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
# https://devdojo.com/bobbyiliev/how-to-install-docker-and-docker-compose-on-raspberry-pi
apt-get install libffi-dev libssl-dev -y
apt install python3-dev -y
apt-get install python3 python3-pip -y
pip3 install docker-compose
usermod -aG docker pi

# Install gps packages
apt-get install gpsd -y

# Host settings
raspi-config nonint do_hostname "elbin"
raspi-config nonint do_i2c 0  # 0 should enable it
cat /etc/default/gpsd | sed -i 's;DEVICES="";DEVICES="/dev/ttyUSB1";' /etc/default/gpsd # Specifies what device is gps receiver

echo ############################
echo ###### Please reboot #######
echo ############################