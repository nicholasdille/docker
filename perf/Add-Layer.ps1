$LayerIndex = -1
do {
    ++$LayerIndex
} while (Test-Path -Path "$PSScriptRoot\Layer_$LayerIndex" -ErrorAction SilentlyContinue)
New-Item -ItemType Directory -Path "$PSScriptRoot\Layer_$LayerIndex" | Out-Null

1..$env:LAYER_FILE_COUNT | ForEach-Object {
    $FileIndex = $_

    $RandomChar = [char](Get-Random -Minimum 0 -Maximum 255)
    $RandomSize = Get-Random -Minimum 1 -Maximum $env:LAYER_FILE_SIZE
    $RandomChar * $RandomSize | Set-Content -Path "$PSScriptRoot\Layer_$LayerIndex\File_$FileIndex"
} | Out-Null