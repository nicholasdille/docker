Install-PackageProvider -Name ContainerImage -Force
Install-ContainerImage -Name WindowsServerCore
Restart-Service -Name docker
docker tag windowsservercore:10.0.14300.1000 windowsservercore:latest