# escape=`

FROM nicholasdille/javaruntime:nano
MAINTAINER nicholas.dille@mailbox.org

SHELL [ "powershell", "-Command" ]

ENV JAVA_MEM_START=32m `
    JAVA_MEM_MAX=1024m

RUN mkdir c:\minecraft,c:\minecraft\config,c:\minecraft\plugins,c:\minecraft\worlds
ADD spigot-1.11.2.jar /
ADD entry.ps1 /
ENTRYPOINT c:\entry.ps1

EXPOSE 25565
EXPOSE 25575

#VOLUME c:\minecraft
