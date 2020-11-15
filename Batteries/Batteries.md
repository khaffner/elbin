# Measuring battery voltages

The motor controller runs on 48V, so we're using 4 parallell packs of 4x 12V batteries in series. \
For the sake of battery health, I like to keep an eye on the voltage of each battery seperately. \
To accomplish this, we're using 4 of these [voltage hats for raspberry pi](https://www.waveshare.com/current-power-monitor-hat.htm).
![Voltage hat](voltage_hat.png)
These can among other things read 4 voltages. \
Each of them have their own Raspberry Pi Zero W, which have a minimal config:
- Connected to boat WiFi
- SSH enabled
- Password changed
- Hostname like batterypack1, batterypack2, etc
- A small Flask webserver
  - pip3 install Flask adafruit_ina219 board
  - See [BatteryServer.py](BatteryServer.py)
  - Run it automatically on boot
  - Home Assistant can query this api