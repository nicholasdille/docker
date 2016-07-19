Set-Location -Path \minecraft

& robocopy /mir  c:\mc_etc c:\minecraft
& robocopy /s /e c:\mc_bin c:\minecraft
& robocopy /s /e c:\mc_var c:\minecraft

$LatestJar = Get-ChildItem spigot-*.jar | Sort-Object LastWriteTime | Select-Object -Last 1 -ExpandProperty Name
& "$Env:ProgramFiles\Java\jre1.8.0_91\bin\Java.exe" -Xmx1024M -Xms32M -jar $LatestJar -W .\worlds