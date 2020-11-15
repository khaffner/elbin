FROM python:3.9.0-slim

RUN pip3 install flask adafruit-circuitpython-ina219 board

ADD BatteryServer.py /app/BatteryServer.py

ENTRYPOINT [ "python3", "/app/BatteryServer.py" ]