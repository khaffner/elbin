# Elbin
The boat is an "Albin Siesta", but named Elbin because of the electrification.
This repo contains everything running on the Raspberry Pies on the boat. \
Every part runs in its own Docker container, and logs as json to files on a shared volume where necessary.

Electric motor info gets pulled via CANbus from the motor controller, a Curtis 1236, using an [USB adapter](https://www.ebay.com/itm/USB-To-CAN-Debugger-USB-CAN-USB2CAN-Converter-Adapter-CAN-Bus-Analyzer/283981754476). \
Battery voltage reading: See separate [documentation](/Batteries/Batteries.md). \
GPS coordinates from [USB GPS antenna](https://www.digitalimpuls.no/diverse/134873s/globalsat-vanntett-gps-mottaker-usb-tilkobling-magnetfeste-48-kanaler), uses gpsd. \
Fjord temperature is measured with an [USB temperature sensor](https://usbtemp.com/). \
Lounge tempereature is measured with an [Aqara temperature sensor](https://www.aqara.com/us/temperature_humidity_sensor.html).\
Motor temperature and bilge water presence is measured with an [Aqara water sensor](https://www.aqara.com/us/water_leak_sensor.html). \
These two sensors are received by a [Conbee 2](https://phoscon.de/en/conbee2) and managed by [deCONZ](https://hub.docker.com/r/marthoc/deconz)\
The bilge pump is controlled by a [Wifi relay](https://www.ebay.com/itm/Sonoff-WiFi-Wireless-witch-Home-Relay-Board-Delay-Module-APP-Smart-Home-Good/283836633645?ssPageName=STRK%3AMEBIDX%3AIT&var=585269344101&_trksid=p2057872.m2749.l2649) \
[Home Assistant](https://www.home-assistant.io/) is the GUI. Reads all the logs every second and visualizes the data and other sensors. \
[Portainer](https://www.portainer.io/) for graphical docker management. Mainly for remote log reading, command line access into containers and image management. \
[DuckDNS](http://www.duckdns.org/) for dns. This runs on mobile data, IP changes often. \
Internet is provided by a [TP-Link TL-MR3020](https://www.prisjakt.no/product.php?e=1034742) for routing, wifi and ethernet, and a USB 3G modem with a data SIM in it.


### Setup on a Raspberry Pi 3B
- sudo apt install git -y
- git clone https://github.com/khaffner/elbin.git /home/pi/elbin
- sudo sh /home/pi/elbin/setup.sh
  - Read it first

### Setup on the Raspberry Pi Zeros
- See separate [documentation](/Batteries/Batteries.md)

### Running
- In the elbin folder, run:
  - docker-compose up --build -d