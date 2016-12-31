FROM microsoft/windowsservercore:10.0.14393.206
MAINTAINER nicholas.dille@mailbox.org

ADD source /source/
ADD AdminDeployment.xml /
RUN start "" /wait c:\source\vs_enterprise.exe /AdminFile AdminDeployment.xml /quiet /norestart /l c:\vs2015.log