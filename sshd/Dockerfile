FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org

# Download materials for Win-OpenSSH
RUN powershell -Command Invoke-WebRequest -Uri 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/5_30_2016/OpenSSH-Win64.zip' -OutFile 'c:\Windows\Temp\OpenSSH-Win64.zip'
RUN powershell -Command Expand-Archive -Path 'c:\Windows\Temp\OpenSSH-Win64.zip' -DestinationPath "$Env:ProgramFiles"

# Create service ssh-agent
RUN [ "powershell", "-Command", "New-Service -Name ssh-agent -BinaryPathName 'c:\\Program Files\\OpenSSH-Win64\\ssh-agent.exe' -Description 'SSH Agent' -StartupType Manual" ]
RUN sc.exe sdset ssh-agent D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)(A;;RP;;;AU)

# Create service sshd
RUN [ "powershell", "-Command", "New-Service -Name sshd -BinaryPathName 'c:\\Program Files\\OpenSSH-Win64\\sshd.exe' -Description 'SSH Deamon' -StartupType Manual -DependsOn ssh-agent" ]
RUN sc.exe config sshd obj= "NT SERVICE\SSHD"
RUN [ "ntrights.exe", "-u \"NT SERVICE\\SSHD\" +r SeAssignPrimaryTokenPrivilege" ]

# Creating firewall exception
RUN powershell -Command New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH

# Creating and importing SSH keys
CMD [ "c:\\Program Files\\OpenSSH-Win64\\ssh-keygen.exe", "-A" ]
CMD powershell -Command Start-Service -Name ssh-agent
CMD [ "c:\\Program Files\\OpenSSH-Win64\\ssh-add.exe", "c:\\Program Files\\OpenSSH-Win64\\ssh_host_dsa_key" ]
CMD [ "c:\\Program Files\\OpenSSH-Win64\\ssh-add.exe", "c:\\Program Files\\OpenSSH-Win64\\ssh_host_rsa_key" ]
CMD [ "c:\\Program Files\\OpenSSH-Win64\\ssh-add.exe", "c:\\Program Files\\OpenSSH-Win64\\ssh_host_ecdsa_key" ]
CMD [ "c:\\Program Files\\OpenSSH-Win64\\ssh-add.exe", "c:\\Program Files\\OpenSSH-Win64\\ssh_host_ed25519_key" ]

# Configuring services
CMD powerShell -Command Set-Service -Name sshd -StartupType Automatic
CMD powerShell -Command Set-Service -Name ssh-agent -StartupType Automatic
CMD powershell -Command Start-Service -Name sshd