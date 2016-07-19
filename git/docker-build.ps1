"$PSScriptRoot\Download.ps1"

'Building image'
docker build -t nicholasdille/git:$GitVersion "$PSScriptRoot"

If ($GitHubReleaseUri -like '*/latest') {
    docker tag nicholasdille/git:$GitVersion nicholasdille/git:latest
}