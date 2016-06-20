$Env:JAVA_HOME = "$Env:ProgramFiles\Java\jre1.8.0u91"
$Env:Path = "$Env:Path;$Env:ProgramFiles\Git\bin;$JAVA_HOME\bin"

#Invoke-WebRequest -Uri "$Env:BuildToolsUrl" -OutFile "$PSScriptRoot\BuildTools.jar"

#& "bash.exe" --login -i -c "java.exe -jar "$PSScriptRoot\BuildTools.jar" --rev 1.9.2"
cd c:\build
java.exe -jar ".\BuildTools.jar"