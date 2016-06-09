FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org

# Setup package management
RUN powershell -Command \
	Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN powershell -Command \
	Install-PackageProvider -Name chocolatey -Force