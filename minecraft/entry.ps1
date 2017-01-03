$env:JAVA_HOME = 'c:\jre'
$env:PATH += ";$env:JAVA_HOME\bin"

$LatestJar = Get-ChildItem -Path c:\ -Filter 'spigot-*.jar' | Sort-Object LastWriteTime | Select-Object -Last 1 -ExpandProperty FullName

Set-Location -Path \minecraft\config
"eula=true" | Set-Content -Path c:\minecraft\config\eula.txt
& java "-Xms$env:JAVA_MEM_START" "-Xmx$env:JAVA_MEM_MAX" -jar "$LatestJar" --plugins C:\minecraft\plugins --world-dir C:\minecraft\worlds