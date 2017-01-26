FROM microsoft/windowsservercore

SHELL [ "powershell", "-Command" ]
ADD profile.ps1 C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\profile.ps1
ADD build.pssc c:/
ADD init.ps1 c:/
RUN Register-PSSessionConfiguration -Name build -Path c:\build.pssc

SHELL [ "powershell", "-ConfigurationName", "build", "-Command" ]

CMD ["powershell"]