"Preparing environment..."
$Env:JAVA_HOME = "c:\jre"
$Env:PATH += ";$Env:JAVA_HOME\bin;c:\git\bin"
Set-Location -Path "$PSScriptRoot"

#Start-Process -FilePath bash.exe -ArgumentList @('--login', '-c', '-i', 'java.exe -jar BuildTools.jar')
#Get-Content -Path "$PSScriptRoot\BuildTools.log.txt" -Wait

"Calling SpigotMC BuildTools..."
java -jar .\BuildTools.jar