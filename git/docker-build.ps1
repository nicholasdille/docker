$GitVersion = ''
$RequiredBitness = '64'
$RequiredExtension = 'exe' #'tar.bz2'

$GitHubReleaseUri = 'https://api.github.com/repos/git-for-windows/git/releases'
If (-Not $GitVersion) {
    $GitHubReleaseUri = "$GitHubReleaseUri/latest"
}
'Using release URI <{0}>' -f $GitHubReleaseUri

$Response = Invoke-WebRequest -Uri $GitHubReleaseUri
$Json = $Response.Content | ConvertFrom-Json
If (-Not $GitVersion -And $Json[0].tag_name -match '^v(.+)\.windows\.1$') {
    $GitVersion = $Matches[1]
}

If (-Not $GitVersion) {
    throw ('Unable to determine version from tag <{0}>' -f $Json.tag_name)
}
'Using Git version <{0}>' -f $GitVersion

$Release = $Json | Where-Object {$_.tag_name -like "v$GitVersion.windows.1"}
$Asset = $Release.assets | Where-Object {$_.name -match "^Git-($GitVersion)-$RequiredBitness-bit.$RequiredExtension$"}
$GitUri = $Asset.browser_download_url
'Using download URI <{0}>' -f $GitUri
If (-Not (Test-Path -Path "$PSScriptRoot\Git-$GitVersion-$RequiredBitness-bit.$RequiredExtension")) {
    'Downloading'
    Invoke-WebRequest -Uri $GitUri -OutFile "$PSScriptRoot\Git-$GitVersion-$RequiredBitness-bit.$RequiredExtension"
}
Copy-Item -Path "$PSScriptRoot\Git-$GitVersion-$RequiredBitness-bit.$RequiredExtension" -Destination "$PSScriptRoot\Git-$RequiredBitness-bit.$RequiredExtension" -Force

'Building image'
docker build -t nicholasdille/git:$GitVersion .

If ($GitHubReleaseUri -like '*/latest') {
    docker tag nicholasdille/git:$GitVersion nicholasdille/git:latest
}