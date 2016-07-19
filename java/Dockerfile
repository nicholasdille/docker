FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org

ADD jre-windows-x64.tar.gz /

RUN [ "powershell", "-Command", "Get-ChildItem -Path c:\\ -Filter 'jre*' -Directory | Rename-Item -NewName jre" ]
RUN [ "powershell", "-Command", "[Environment]::SetEnvironmentVariable('JAVA_HOME', 'c:\\jre', 'Machine')" ]

CMD [ "c:\\jre\\bin\\java.exe", "-version" ]