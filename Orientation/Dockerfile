# Credits to https://github.com/bmwshop/sensehat/blob/master/Dockerfile

FROM mcr.microsoft.com/powershell:lts-arm32v7-ubuntu-18.04

RUN apt-get update && apt-get install -y curl python-numpy python-pil 
WORKDIR /tmp

RUN curl -LO  https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib-dev_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib//librtimulib-utils_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/librtimulib7_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/r/rtimulib/python-rtimulib_7.2.1-3_armhf.deb \
 && curl -LO https://archive.raspberrypi.org/debian/pool/main/p/python-sense-hat/python-sense-hat_2.1.0-1_armhf.deb
 
RUN dpkg -i librtimulib-dev_7.2.1-3_armhf.deb librtimulib-utils_7.2.1-3_armhf.deb librtimulib7_7.2.1-3_armhf.deb python-rtimulib_7.2.1-3_armhf.deb python-sense-hat_2.1.0-1_armhf.deb

RUN mkdir /app
ADD /Orientation/Orientation.py /app/Orientation.py
ADD /Orientation/LogOrientation.ps1 /app/LogOrientation.ps1
ADD profile.ps1 /opt/microsoft/powershell/7/profile.ps1

# Generated with https://www.raspberrypi.org/documentation/hardware/sense-hat/
ADD /Orientation/RTIMULib.ini /etc/RTIMULib.ini

RUN rm -f /tmp/*.deb
RUN apt-get clean

WORKDIR /

ENTRYPOINT [ "pwsh", "-File", "/app/LogOrientation.ps1" ]