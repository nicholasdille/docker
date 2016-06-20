docker build -t nicholasdille/spigotmc-build .

docker run -d --name build -w c:\build nicholasdille/spigotmc-build powershell -command .\RunBuildTools.ps1

docker cp build:c:\build\spigot-*.jar .