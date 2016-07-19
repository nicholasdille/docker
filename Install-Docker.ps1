Add-WindowsFeature -Name Containers -Restart

#Install-PackageProvider -Name ContainerImage -Force
#Install-ContainerImage -Name WindowsServerCore

$DockerPath = "$Env:ProgramFiles\docker"

If (-Not (Test-Path -Path $DockerPath)) {
    New-Item -Type Directory -Path $DockerPath | Out-Null
}

If ($Env:Path -like '*\Docker*') {
    [Environment]::SetEnvironmentVariable("Path", $Env:Path + ";$DockerPath", [EnvironmentVariableTarget]::Machine)
    $Env:Path = $Env:Path + ";$Env:ProgramFiles\Docker"
}

If (Get-Service -Name 'docker') {
    # update?

} else {
    # Download docker engine
    Invoke-WebRequest https://master.dockerproject.org/windows/amd64/dockerd.exe -OutFile "$DockerPath\dockerd.exe"
    # Register docker engine service
    & "$env:ProgramFiles\docker\dockerd" --register-service
    # Start docker engine
    Start-Service Docker
    # Add firewall rule
    New-NetFirewallRule -Name 'docker' -DisplayName 'Docker Engine' -Direction Inbound -Protocol TCP -LocalPort 2376 -Action Allow -Enabled True -Profile Domain,Private
}

# Download docker client
Invoke-WebRequest https://master.dockerproject.org/windows/amd64/docker.exe -OutFile "$DockerPath\docker.exe"

Start-BitsTransfer https://aka.ms/tp5/6b/docker/nanoserver -Destination "$Env:Temp\nanoserver.tar.gz"
Start-BitsTransfer https://aka.ms/tp5/6b/docker/windowsservercore -Destination "$Env:Temp\windowsservercore.tar.gz"

docker load -i "$Env:Temp\nanoserver.tar.gz"
docker load -i "$Env:Temp\windowsservercore.tar.gz"

docker tag microsoft/nanoserver:10.0.14300.1030 microsoft/nanoserver:latest
docker tag microsoft/windowsservercore:10.0.14300.1030 microsoft/windowsservercore:latest

Set-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers' -Name VSmbDisableOplocks -Type DWord -Value 1 -Force
Restart-Computer