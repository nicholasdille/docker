$Env:JAVA_HOME = "$Env:ProgramFiles\Java\jre1.8.0u91"
$Env:Path = "$Env:Path;$Env:ProgramFiles\Git\bin;$JAVA_HOME\bin"

cd c:\build

Invoke-WebRequest -Uri "$Env:BuildToolsUrl" -OutFile ".\BuildTools.jar"

#& "bash.exe" --login -i -c "java.exe -jar "$PSScriptRoot\BuildTools.jar" --rev 1.9.2"
java.exe -jar ".\BuildTools.jar"