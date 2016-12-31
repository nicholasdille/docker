$DownloadPageUri = 'http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html'
$JavaVersion = '8u111'

$Response = Invoke-WebRequest -Uri $DownloadPageUri
$JreUri = @($Response.RawContent -split "`n" | ForEach-Object {If ($_ -imatch '"filepath":"(http://[^"]+)"') {$Matches[1]}} | Where-Object {$_ -like "*-$JavaVersion-windows-x64.tar.gz"})
If (-Not $JreUri.Count -eq 1) {
    throw ('Expected to retrieve only one URI but got {0}' -f $JreUri.Count)
}

If ($JreUri[0] -imatch '/([^/]+)$') {
    $JreFileName = $Matches[1]
}
$JreFileName = 'jre-windows-x64.tar.gz'

If (-Not (Test-Path -Path "$PSScriptRoot\$JreFileName") -Or -Not (Test-Path -Path "$PSScriptRoot\Java-$JavaVersion.tag")) {
    $Cookie  = New-Object -TypeName System.Net.Cookie
    $Cookie.Domain = 'oracle.com'
    $Cookie.Name   = 'oraclelicense'
    $Cookie.Value  = 'accept-securebackup-cookie'
    $Session = New-Object -TypeName Microsoft.PowerShell.Commands.WebRequestSession
    $Session.Cookies.Add($Cookie)
    Invoke-WebRequest -Uri $JreUri[0] -WebSession $Session -OutFile "$PSScriptRoot\$JreFileName"
    New-Item -Path "$PSScriptRoot\Java-$JavaVersion.tag" -ItemType File | Out-Null
}