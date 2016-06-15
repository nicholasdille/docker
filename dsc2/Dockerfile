FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org
LABEL Description="PowerShell Desired State Configuration" Vendor="Nicholas Dille" Version="0.1"

# Install Windows features
RUN powershell -Command \
    Add-WindowsFeature -Name Dsc-Service -Verbose

# Create directory for persistent files
RUN powershell -Command \
    New-Item -Path c:\docker        -ItemType Directory -Force

# Install PSDSC resource modules
ADD cChoco c:\docker
RUN powershell -Command Get-ChildItem -Path c:\docker
RUN powershell -Command \
    Move-Item -Path c:\docker\* -Destination 'c:\Program Files\WindowsPowerShell\Modules\cChoco' -Verbose -Force

# Install chocolatey packages using PSDSC
ADD EnsurePackage.ps1 c:\docker
RUN powershell -Command \
    c:\docker\EnsurePackage.ps1 -Name Win32-OpenSSH,docker