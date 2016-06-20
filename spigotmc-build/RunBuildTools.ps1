$Env:JAVA_HOME = "$Env:ProgramFiles\Java\jre1.8.0u91"
$Env:Path = "$Env:Path;$Env:ProgramFiles\Git\bin;$JAVA_HOME\bin"

Set-Location -Path c:\build
java.exe -jar BuildTools.jar