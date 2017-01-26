FROM microsoft/windowsservercore

SHELL ["powershell", "-Command"]

ADD bootstrap c:\bootstrap
ADD Invoke-Bootstrap.ps1 c:/
VOLUME c:\\data
ENTRYPOINT c:\Invoke-Bootstrap.ps1