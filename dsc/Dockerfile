FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org
LABEL Description="PowerShell Desired State Configuration" Vendor="Nicholas Dille" Version="0.1"

RUN powershell -Command \
    Install-Module -Name xPSDesiredStateConfiguration -Force

RUN powershell -Command \
    New-Item -Path c:\docker -ItemType Directory -Force

ADD MetaConfiguration.ps1 c:\docker
RUN powerShell -Command \
    c:\docker\MetaConfiguration.ps1

# Install Windows features
RUN powershell -Command \
    Install-Module -Name cChoco -Force

ADD EnsurePackage.ps1 c:\docker
RUN powershell -Command \
    c:\docker\EnsurePackage.ps1 -Name git,Win32-OpenSSH

COPY SetNodeName.ps1 c:\docker
ENTRYPOINT c:\docker\SetNodeName.ps1

CMD ping -t localhost