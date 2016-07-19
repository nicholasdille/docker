"$PSScriptRoot\Download.ps1"

& docker build -t nicholasdille/javaruntime:$JavaVersion "$PSScriptRoot"
& docker tag nicholasdille/javaruntime:$JavaVersion nicholasdille/javaruntime:latest