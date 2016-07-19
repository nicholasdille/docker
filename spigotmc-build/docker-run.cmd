@Echo Off

docker run -d --name build -w c:\build nicholasdille/spigotmc-build powershell -command c:\build\RunBuildTools.ps1
docker wait build
docker logs --tail=5 build

for /f "usebackq tokens=4" %%i in (`docker logs --tail=1 build`) do @docker cp build:c:\build\%%i .