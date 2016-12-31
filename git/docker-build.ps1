. "$PSScriptRoot\Download.ps1"

'Building image'
docker build -f Dockerfile.core -t nicholasdille/git:$GitVersion "$PSScriptRoot"
docker build -f Dockerfile.java-core -t nicholasdille/git:$($GitVersion)-java "$PSScriptRoot"

If ($GitHubReleaseUri -like '*/latest') {
    docker tag nicholasdille/git:$GitVersion nicholasdille/git:latest
    docker tag nicholasdille/git:$($GitVersion)-java nicholasdille/git:java
}