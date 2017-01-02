# escape=`

FROM nicholasdille/git:java
MAINTAINER nicholas.dille@mailbox.org

SHELL [ "powershell", "-Command" ]

RUN mkdir c:\build | Out-Null
ADD RunBuildTools.ps1 c:\build
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar /build/BuildTools.jar

ENTRYPOINT [ "powershell" ]
CMD c:\build\RunBuildTools.ps1