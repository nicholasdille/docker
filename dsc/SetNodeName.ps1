Param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]
    $ComputerName
)

Configuration SetNodeName {
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ComputerName
    )

    Node 'localhost' {
        LocalConfigurationManager {
            ConfigurationID = $ComputerName
        }
    }
}

SetNodeName -ComputerName $ComputerName -OutputPath "$PSScriptRoot\Output"
Set-DscLocalConfigurationManager -Path "$PSScriptRoot\Output" -Verbose

if ($args.Count -gt 0) {
    $Command = $args[0]
    If ($args.Count -gt 1) {
        $Arguments = $args[1..($args.Count - 1)]
    }
    & $Command $Arguments

} else {
    while ($true) { Start-Sleep -Seconds 60 }
}