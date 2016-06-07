Configuration MetaConfiguration {
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $NodeName
    )

    Node 'localhost' {
        LocalConfigurationManager {
            ConfigurationID = $NodeName
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RebootNodeIfNeeded = $true
            ActionAfterReboot = 'ContinueConfiguration'
        }
    }
}

MetaConfiguration -NodeName 'Test' -OutputPath "$PSScriptRoot\Output"
Set-DscLocalConfigurationManager -Path "$PSScriptRoot\Output" -Verbose