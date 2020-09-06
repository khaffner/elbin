# Assumes:
#   The hostname should be elbin 
#   The username is pi
#   The host is a Raspberry Pi 3B
# Run this script with sudo, with this repo folder as working directory

# Update the system
apt-get update
apt-get upgrade

# Install docker and docker compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
# https://devdojo.com/bobbyiliev/how-to-install-docker-and-docker-compose-on-raspberry-pi
apt-get install libffi-dev libssl-dev -y
apt install python3-dev -y
apt-get install python3 python3-pip -y
pip3 install docker-compose
usermod -aG docker pi

# Install gps packages, Home Assistant telnets to the port enabled by gpsd.
apt-get install gpsd -y

# Host settings
raspi-config nonint do_hostname "elbin"
cat /etc/default/gpsd | sed -i 's;DEVICES="";DEVICES="/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0";' /etc/default/gpsd # Specifies what device is gps receiver

echo ############################
echo ###### Please reboot #######
echo ############################