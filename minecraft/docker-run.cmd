git clone https://github.com/nicholasdille/minecraft.git

docker run -d --name minecraft -v c:\minecraft_etc:c:\mc_etc:ro -v c:\minecraft_bin:c:\mc_bin:ro -v c:\minecraft_var:c:\mc_var:ro -p 25565:25565 -p 25575:25575 spigotmc2 powershell -command c:\minecraft.ps1

#docker cp minecraft:c:\minecraft\logs c:\minecraft_bak\logs
#docker cp minecraft:c:\minecraft\worlds c:\minecraft_bak\worlds
#docker cp minecraft:c:\minecraft\backup c:\minecraft_bak\backup

#robocopy /mir c:\minecraft_bak c:\minecraft_var
#cmd /c del /s /q c:\minecraft_bak\*
#cmd /c rd /s /q c:\minecraft_bak\worlds c:\minecraft_bak\logs c:\minecraft_bak\backup

#docker rm minecraft