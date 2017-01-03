[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] 
    $ServiceName
    ,
    [ValidateNotNullOrEmpty()]
    [int] 
    $StartupTimeout = 10
    ,
    [switch] 
    $AllowServiceRestart
)

if (-Not (Get-Service -Name $ServiceName -ErrorAction SilentlyContinue)) {
    throw ('Service called {0} not found.' -f $ServiceName)
}

Write-Host ('Waiting for service {0} to start (timeout: {1} seconds)...' -f $ServiceName, $StartupTimeout)
$StartupDuration = 0
while ($StartupDuration -lt $StartupTimeout -and @('Stopped', 'Running') -inotcontains (Get-Service -Name $ServiceName -ErrorAction SilentlyContinue).Status) {
    Start-Sleep -Milliseconds 100
    $StartupDuration += 0,1
}
if ((Get-Service -Name $ServiceName -ErrorAction SilentlyContinue).Status -ine 'Running') {
    throw ('Service {0} did not enter running state during startup interval of {1} seconds.' -f $ServiceName, $StartupTimeout)
}
Write-Host ('Service {0} entered running start.' -f $ServiceName)

Write-Host ('Monitoring service {0} (automatic restart is {1})...' -f $ServiceName, $AllowServiceRestart)
do {
    while (@('Running') -icontains (Get-Service -Name $ServiceName -ErrorAction SilentlyContinue).Status) {
        Start-Sleep -Milliseconds 100
    }
    
    if ($AllowServiceRestart) {
        Write-Warning ('Restarting service {0}...' -f $ServiceName)
        Restart-Service -Name $ServiceName -ErrorAction SilentlyContinue
    }

} while ($AllowServiceRestart)

Write-Host ('Finished monitoring service {0}.' -f $ServiceName)