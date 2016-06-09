FROM windowsservercore
MAINTAINER nicholas.dille@haufe-lexware.com

# Download materials for Win-OpenSSH
RUN powershell -Command Invoke-WebRequest -Uri 'https://live.sysinternals.com/psexec.exe' -OutFile 'c:\Windows\Temp\psexec.exe'

RUN c:\windows\temp\psexec.exe -accepteula -s cmd /c whoami