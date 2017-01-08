$LayerIndex = -1
do {
    ++$LayerIndex
} while (Test-Path -Path "$PSScriptRoot\Layer_$LayerIndex" -ErrorAction SilentlyContinue)
New-Item -ItemType Directory -Path "$PSScriptRoot\Layer_$LayerIndex" | Out-Null

1..$env:LAYER_FILE_COUNT | ForEach-Object {
    $FileIndex = $_

    # SLOW
    #$out = @()
    #0..$env:LAYER_FILE_SIZE | ForEach-Object {
    #    $out += Get-Random -Minimum 0 -Maximum 255
    #}
    #[System.IO.File]::WriteAllBytes("$PSScriptRoot\Layer_$LayerIndex\File_$FileIndex", $out)

    # ZERO SIZE
    #New-Item -ItemType File -Path "$PSScriptRoot\Layer_$LayerIndex\File_$FileIndex"

    ' ' * $env:LAYER_FILE_SIZE | Set-Content -Path "$PSScriptRoot\Layer_$LayerIndex\File_$FileIndex"
} | Out-Null