$MsBuildPath = Get-ChildItem -Path 'C:\Program Files (x86)\MSBuild\' -File -Recurse -Filter 'msbuild.exe' | Select-Object -ExpandProperty DirectoryName -First 1
$env:PATH += ";$MsBuildPath"

if ($args.Length -gt 0) {
    $RunCommand = 'msbuild.exe'
    $RunParams = @('/version')
} else {
    $RunCommand = $args[0]
    $RunParams = $args[1 .. ($args.Length - 1)]
}

& $RunCommand @RunParams