FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org

ADD http://javadl.oracle.com/webapps/download/AutoDL?BundleId=207775 c:\jre-8u91-windows-x64.exe
RUN powershell -Command \
    Start-Process -FilePath C:\jre-8u91-windows-x64.exe -PassThru -Wait -ArgumentList \"/s /L c:\Java64.log\"
RUN del c:\jre-8u91-windows-x64.exe

VOLUME c:\minecraft

#