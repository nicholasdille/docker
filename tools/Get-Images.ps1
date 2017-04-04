$Images = Get-ChildItem -Path . -File -Recurse | Where-Object {$_.Name -eq 'Dockerfile'} | Select-Object -ExpandProperty Directory | Select-Object -ExpandProperty FullName | ForEach-Object{$_.Replace((Get-Location).Path + '\', '')}

'Source | Image | Run | Build'
'-------|-------|-----|------'
$Images | ForEach-Object {
    $result = "[Source](https://github.com/nicholasdille/docker/tree/master/$_) | "
    if () {
        $result += "[DockerHub](https://hub.docker.com/r/nicholasdille/$_) | docker run nicholasdille/$_ | "
    } else {
        $result += " | | "
    }
    $result = "docker build https://github.com/nicholasdille/docker.git#master:$_"

    $result
}
