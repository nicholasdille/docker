$env:PATH += ";c:\git\bin"

if ($args.Length -eq 0) {
    $RunCommand = 'git'
    $RunParams = @('--version')
} else {
    $RunCommand = $args[0]
    $RunParams = $args[1 .. ($args.Length - 1)]
}

& $RunCommand @RunParams