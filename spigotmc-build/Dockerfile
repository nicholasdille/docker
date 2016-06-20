FROM windowsservercore
MAINTAINER nicholas.dille@mailbox.org

ADD https://github.com/git-for-windows/git/releases/download/v2.9.0.windows.1/Git-2.9.0-64-bit.exe c:\Git-2.9.0-64-bit.exe
RUN c:\Git-2.9.0-64-bit.exe /SILENT
RUN del c:\Git-2.9.0-64-bit.exe

ADD http://javadl.oracle.com/webapps/download/AutoDL?BundleId=207775 c:\jre-8u91-windows-x64.exe
RUN powershell -Command \
    Start-Process -FilePath C:\jre-8u91-windows-x64.exe -PassThru -Wait -ArgumentList \"/s /L c:\Java64.log\"
RUN del c:\jre-8u91-windows-x64.exe

RUN md c:\build
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar c:\build\BuildTools.jar
ADD RunBuildTools.ps1 c:\build
CMD powershell -command c:\build\RunBuildTools.ps1