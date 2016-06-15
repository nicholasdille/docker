Param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    $Name
)

Configuration EnsurePackage {
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Name
    )

    Import-DscResource -ModuleName cChoco

    Node 'localhost' {

        cChocoInstaller chocolatey {
            InstallDir = "$Env:ProgramFiles\Chocolatey"
        }
        
        ForEach ($PackageName In $Name) {
            cChocoPackageInstaller "Package_$PackageName" {
                Name = "$PackageName"
                DependsOn = '[cChocoInstaller]chocolatey'
            }
        }

    }
}

EnsurePackage -Name $Name -OutputPath "$PSScriptRoot\Output"
Start-DscConfiguration -Path "$PSScriptRoot\Output" -Wait -Verbose