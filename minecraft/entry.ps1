$env:JAVA_HOME = 'c:\jre'
$env:PATH += ";$env:JAVA_HOME\bin"

#$LatestJar = Get-ChildItem spigot-*.jar | Sort-Object LastWriteTime | Select-Object -Last 1 -ExpandProperty Name

Set-Location -Path \minecraft\config
"eula=true" | Set-Content -Path c:\minecraft\config\eula.txt
& java "-Xms$env:JAVA_MEM_START" "-Xmx$env:JAVA_MEM_MAX" -jar c:\spigot-1.11.2.jar --plugins C:\minecraft\plugins --world-dir C:\minecraft\worlds