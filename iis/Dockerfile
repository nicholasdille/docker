FROM nicholasdille/service

SHELL [ "powershell", "-Command" ]

RUN Add-WindowsFeature -Name Web-Server
CMD [ "w3svc" ]

EXPOSE 80