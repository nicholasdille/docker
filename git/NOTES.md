# Git Archive

ADD Git-64-bit-tar-bz2 /git

# Git Install

ADD Git-64-bit.exe /
# http://www.jrsoftware.org/ishelp/index.php?topic=setupcmdline
#RUN powershell -Command \
#    Start-Process -FilePath c:\Git-64-bit.exe -PassThru -Wait -ArgumentList \"/VERYSILENT /NORESTART /NOCANCEL /SP- /SUPPRESSMSGBOXES /DIR=c:\\git\"
#RUN c:\Git-64-bit.exe /VERYSILENT /NORESTART /NOCANCEL /SP- /SUPPRESSMSGBOXES /DIR=c:\\git
RUN [ "c:\\Git-64-bit.exe", "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/SUPPRESSMSGBOXES", "/DIR=c:\\git" ]
RUN del c:\Git-64-bit.exe

## Variant

```Dockerfile
ADD Git-64-bit.exe /
ADD install.ps1 /
RUN [ "powershell", "-command", "c:\\install.ps1" ]
```

# PowerShell Package Provider

```Dockerfile
RUN powershell -Command \
    Install-PackageProvider -Name chocolatey; \
    Import-PackageProvider -Name chocolatey; \
    Set-PackageSource -Name chocolatey -Trusted; \
    Install-Package -Name git -Source chocolatey -Force
```

# Chocolatey

```Dockerfile
RUN powershell -Command \
    Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN [ "choco", "install", "git", "-y" ]
```