Configuration SetNodeName {
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $NodeName
    )

    Node 'localhost' {
        LocalConfigurationManager {
            ConfigurationID = $NodeName
        }
    }
}

If ($Env:NODENAME) {
    SetNodeName -NodeName $Env:NODENAME -OutputPath "$PSScriptRoot\Output"
    Set-DscLocalConfigurationManager -Path "$PSScriptRoot\Output" -Verbose
}

$Command = $args[0]
If ($args.Count -gt 1) {
    $Arguments = $args[1..($args.Count - 1)]
}
& $Command $Arguments