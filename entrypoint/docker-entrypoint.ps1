New-Item -Path c:\entry\docker-entrypoint.txt -ItemType File -Force

Get-ChildItem -Path Env:\ | Out-File -FilePath c:\entry\env.txt -Force

If ($Env:NODENAME) {
    'Got NODENAME={0}' -f $Env:NODENAME | Out-File -FilePath c:\entry\NODENAME.txt -Force

} else {
    'Got no NODENAME' | Out-File -FilePath c:\entry\NODENAME.txt -Force
}

$Command = $args[0]
If ($args.Count -gt 1) {
    $Arguments = $args[1..($args.Count - 1)]
}

& $Command $Arguments