# Elbin
Everything running on the raspberry pi on the boat named elbin. \
Electric motor info gets pulled via CAN. \
GPS coordinates from usb gps antenna, uses gpsd. \
Home Assistant is the UI.


### Setup
- sudo apt install git -y
- git clone https://github.com/khaffner/elbin.git /home/pi/elbin
- sudo sh /home/pi/elbin/setup.sh
  - Read it first

### Running
- In the elbin folder, run:
  - docker-compose up --build