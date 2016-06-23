@Echo Off

docker run -d --name build nicholasdille/spigotmc-build
docker wait build
docker logs --tail=5 build

for /f "usebackq tokens=4" %%i in (`docker logs --tail=1 build`) do @docker cp build:c:\build\%%i .