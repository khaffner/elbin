# arm32v6 is sadly only alpine-based, needs to be debian-based
FROM arm32v5/python:3.9-buster

RUN apt-get update && apt-get install python3-rpi.gpio i2c-tools -y
RUN pip3 install RPi.GPIO
RUN pip3 install board
RUN pip3 install flask 
RUN pip3 install adafruit-circuitpython-ina219 

ADD BatteryServer.py /app/BatteryServer.py

ENTRYPOINT [ "python3", "/app/BatteryServer.py" ]