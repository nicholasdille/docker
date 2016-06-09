FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org
LABEL Description="EntryPoint" Vendor="Nicholas Dille" Version="0.1"

RUN powershell -Command \
    New-Item -Path c:\docker,c:\entry -ItemType Directory -Force

ADD docker-entrypoint.ps1 /docker/
ENTRYPOINT powershell -command c:\docker\docker-entrypoint.ps1

CMD ping -t localhost