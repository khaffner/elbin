# Measuring battery voltages

The motor controller runs on 48V, so we're using 4 parallell packs of 4x 12V batteries in series. \
For the sake of battery health, I like to keep an eye on the voltage of each battery seperately. \
To accomplish this, we're using 4 of these [voltage hats for raspberry pi](https://www.waveshare.com/current-power-monitor-hat.htm).
![Voltage hat](voltage_hat.png)
These can among other things read 4 voltages. \
Each of them have their own Raspberry Pi Zero W, which have this config:
- Connected to boat WiFi
- SSH enabled
- Password changed
- Hostname like batterypack1, batterypack2, etc
- Docker and docker-compose installed
  - curl -fsSL https://get.docker.com -o get-docker.sh
  - sudo sh get-docker.sh
  - sudo usermod -aG docker pi
  - sudo apt install python3-pip libffi-dev -y
  - sudo pip3 install docker-compose
- A small Flask webserver running on docker. See [BatteryServer.py](BatteryServer.py).
  - docker-compose up --build
    - See [docker-compose.yml](docker-compose.yml) for details
  - Home Assistant can now query http://batterypack1.local/1, and get the voltage of the first battery in the first pack.