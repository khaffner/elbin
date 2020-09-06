FROM mcr.microsoft.com/powershell:lts-arm32v7-ubuntu-18.04

RUN apt-get update && apt-get install digitemp -y

RUN mkdir /app
ADD LogTemp.ps1 /app
ADD profile /opt/microsoft/powershell/7/profile.ps1
RUN mkdir /logs

ENTRYPOINT [ "pwsh", "-File", "/app/LogTemp.ps1" ]