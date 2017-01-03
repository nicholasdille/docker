FROM microsoft/windowsservercore

SHELL [ "powershell", "-Command" ]

ADD profile.ps1 C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\profile.ps1

ADD Test-Service.ps1 /
ENTRYPOINT [ "powershell", "-Command", "c:\\Test-Service.ps1", "-ServiceName" ]