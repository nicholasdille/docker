Get-ChildItem -Path c:\ -Directory -Filter 'Layer_*' | ForEach-Object {
    Measure-Command { Get-ChildItem -Path $_ -File | Get-Content | Out-Null } | Select-Object -ExpandProperty TotalSeconds
}