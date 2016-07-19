FROM nicholasdille/javaruntime:8u91
MAINTAINER nicholas.dille@mailbox.org

EXPOSE 25565
EXPOSE 25575

VOLUME c:\\mc_etc
VOLUME c:\\mc_bin
VOLUME c:\\mc_var

RUN md c:\minecraft

ADD minecraft.ps1 /
CMD powershell -command c:\minecraft.ps1