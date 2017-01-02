# escape=`

FROM microsoft/windowsservercore:10.0.14393.576
MAINTAINER nicholas.dille@mailbox.org

SHELL [ "powershell", "-Command" ]

RUN Install-WindowsFeature -Name NET-Framework-45-Core; `
    Invoke-WebRequest `
        -UseBasicParsing `
        -Uri "https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe" `
        -OutFile "$env:TEMP\BuildTools_Full.exe"; `
    Start-Process -Wait -PassThru -FilePath "$env:TEMP\BuildTools_Full.exe" -ArgumentList '/Silent /Full'; `
    Remove-Item -Path "$env:TEMP\BuildTools_Full.exe" -Force; `
    Invoke-WebRequest `
        -UseBasicParsing `
        -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" `
        -OutFile "C:\windows\nuget.exe"

ADD entry.ps1 /
ENTRYPOINT c:\entry.ps1
CMD [ "msbuild.exe", "/version" ]