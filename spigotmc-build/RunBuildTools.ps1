$Env:JAVA_HOME = "c:\jre"
$Env:Path = "$Env:Path;$Env:ProgramFiles\Git\bin;$JAVA_HOME\bin"

Set-Location -Path c:\build
java.exe -jar BuildTools.jar