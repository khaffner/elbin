# Elbin
The boat is an "Albin Siesta", but named Elbin because of the electrification.
This repo contains everything running on the Raspberry Pi on the boat. \
Every part runs in its own Docker container, and logs as json to files on a shared volume. \

Electric motor info gets pulled via CANbus. HW TBD. \
GPS coordinates from [USB GPS antenna](https://www.digitalimpuls.no/diverse/134873s/globalsat-vanntett-gps-mottaker-usb-tilkobling-magnetfeste-48-kanaler), uses gpsd. \
Temperature is measured with an [USB temperature sensor](https://usbtemp.com/). \
Home Assistant is the GUI. Reads all the logs every second and visualizes the data. \
Portainer for graphical docker management. Mainly for remote log reading and image management. \
DuckDNS for dns. This runs on mobile data, IP changes often. \
Syncthing for syncing(/"backup") of docker volumes to off site computer. \
Heimdall for "front page" on LAN. \
Internet is provided by a [TP-Link TL-MR3020](https://www.prisjakt.no/product.php?e=1034742) for routing, wifi and ethernet, and a USB 3G modem with a data SIM in it.


### Setup on a Raspberry Pi
- sudo apt install git -y
- git clone https://github.com/khaffner/elbin.git /home/pi/elbin
- sudo sh /home/pi/elbin/setup.sh
  - Read it first

### Running
- In the elbin folder, run:
  - docker-compose up --build -d