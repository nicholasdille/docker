FROM microsoft/windowsservercore
MAINTAINER nicholas.dille@mailbox.org

ENV GO_VERSION "16.6.0"
ENV GO_AGENT_JAVA_HOME "c:\Program Files\Java\jre1.8.0_91"
ENV GO_SERVER "localhost"
ENV GO_SERVER_PORT "8153"

ADD jre-windows-x64.tar.gz /
RUN [ "powershell", "-Command", "Get-ChildItem -Path c:\\ -Filter 'jre*' -Directory | Rename-Item -NewName jre" ]
RUN [ "powershell", "-Command", "[Environment]::SetEnvironmentVariable('JAVA_HOME', 'c:\\jre', 'Machine')" ]

ADD Git-64-bit.exe /
RUN powershell -Command \
    Start-Process -FilePath c:\Git-64-bit.exe -PassThru -Wait -ArgumentList \"/VERYSILENT /NORESTART /NOCANCEL /SP- /SUPPRESSMSGBOXES /DIR=c:\\git\"

ADD go-agent-$GO_VERSION /go-agent-16.6.0
ADD run-agent.cmd /

CMD c:\run-agent.cmd