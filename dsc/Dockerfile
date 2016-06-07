FROM nicholasdille/git
MAINTAINER nicholas.dille@mailbox.org

# Install Windows features
RUN powershell -Command Add-WindowsFeature Dsc-Service

# Install DSC resources
#RUN [ "powershell", "-Command", "Set-Location -Path 'c:\\Program Files\\WindowsPowerShell\\Modules'; & 'c:\\Program Files\\Git\\bin\\git.exe' clone https://github.com/PowerShell/xPSDesiredStateConfiguration.git" ]
RUN powershell -Command Install-Module -Name xPSDesiredStateConfiguration -Force

# Apply DSC configuration
ADD MetaConfiguration.ps1 /windows/temp
RUN powershell -ExecutionPolicy ByPass c:\Windows\Temp\MetaConfiguration.ps1