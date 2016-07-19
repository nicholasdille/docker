$goAgentVersion = '16.6.0'
$goAgentBuild   = "$goAgentVersion-3590"

If (-Not (Test-Path -Path "$PSScriptRoot\go-agent-$goAgentBuild.zip")) {
    Invoke-WebRequest -Uri "https://download.go.cd/binaries/$goAgentBuild/generic/go-agent-$goAgentBuild.zip" -OutFile "$PSScriptRoot\go-agent-$goAgentBuild.zip"
}

If (-Not (Test-Path -Path "$PSScriptRoot\go-agent-$goAgentVersion")) {
    Expand-Archive -Path "$PSScriptRoot\go-agent-$goAgentBuild.zip" -DestinationPath "$PSScriptRoot"
}

& docker build -t gocd-agent "$PSScriptRoot"