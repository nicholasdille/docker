if ((docker ps -qaf "name=spigotmc-build" | Measure-Object -Line).Lines -eq 0) {
    "Running build..."
    & docker run -it --name spigotmc-build nicholasdille/spigotmc-build
}
"Extracting file name..."
$Line = & docker logs spigotmc-build | Select-Object -Last 1
if ($Line -match '(spigot-.+\.jar)') {
    $FileName = $Matches[1]
    "  Matches file name: $FileName"

    "Retrieving JAR file..."
    & docker cp spigotmc-build:c:\build\$FileName .
}
"Done."