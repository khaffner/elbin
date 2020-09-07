FROM mcr.microsoft.com/powershell:lts-arm32v7-ubuntu-18.04

RUN apt-get update && apt-get install can-utils -y
RUN mkdir /logs

ADD /Motor/LogMotor.ps1 /app/LogMotor.ps1

ENTRYPOINT [ "pwsh", "-File", "/app/LogMotor.ps1" ]