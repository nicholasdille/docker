FROM nicholasdille/javaruntime:8u91
MAINTAINER nicholas.dille@mailbox.org

ADD https://github.com/git-for-windows/git/releases/download/v2.9.0.windows.1/Git-2.9.0-64-bit.exe c:\Git-2.9.0-64-bit.exe
RUN c:\Git-2.9.0-64-bit.exe /SILENT
RUN del c:\Git-2.9.0-64-bit.exe

RUN md c:\build
ADD RunBuildTools.ps1 c:\build
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar /build/BuildTools.jar

CMD powershell -command c:\\build\\RunBuildTools.ps1