Set JAVA_HOME=%~dp0..\Java
Set PATH=%PATH%;%JAVA_HOME%\Bin

%~d0
cd "%~dp0"
Java -Xmx1024M -Xms32M -jar "%~dp0spigot-1.9.2.jar" -W ./worlds