$env:PATH += ";$env:JAVA_HOME\bin"

if ($args.Length -eq 0) {
    $RunCommand = 'java'
    $RunParams = @('-version')
} else {
    $RunCommand = $args[0]
    $RunParams = $args[1 .. ($args.Length - 1)]
}

& $RunCommand @RunParams