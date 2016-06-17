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

ping -t localhost
