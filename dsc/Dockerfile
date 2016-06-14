FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org
LABEL Description="PowerShell Desired State Configuration" Vendor="Nicholas Dille" Version="0.1"

# Install Windows features
RUN powershell -Command \
    Add-WindowsFeature -Name Dsc-Service -Verbose

# Create directory for persistent files
RUN powershell -Command \
    New-Item -Path c:\docker -ItemType Directory -Force

# Apply PSDSC meta configuration
ADD MetaConfiguration.ps1 c:\docker
RUN powerShell -Command \
    c:\docker\MetaConfiguration.ps1

# Configuration variables
ENV nodename _

# Create entrypoint
COPY SetNodeName.ps1 c:\docker

# Set configuration ID on container creation
CMD powershell c:\docker\SetNodeName.ps1 %nodename%