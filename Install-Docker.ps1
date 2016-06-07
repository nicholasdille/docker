$DockerPath = "$Env:ProgramFiles\docker"

If (Test-Path -Path $DockerPath) {
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
    Invoke-WebRequest 'https://aka.ms/tp5/b/dockerd' -OutFile "$DockerPath\dockerd.exe"
    # Register docker engine service
    dockerd --register-service
    # Start docker engine
    Start-Service Docker
    # Add firewall rule
    New-NetFirewallRule -Name 'docker' -DisplayName 'Docker Engine' -Direction Inbound -Protocol TCP -LocalPort 2376 -Action Allow -Enabled True -Profile Any
}

# Download docker client
Invoke-WebRequest 'https://aka.ms/tp5/b/docker'  -OutFile "$DockerPath\docker.exe"
