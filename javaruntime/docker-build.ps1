$ErrorActionPreference = 'Stop'

. "$PSScriptRoot\Download.ps1"

& docker build -f Dockerfile.core -t nicholasdille/javaruntime:$($JavaVersion)-core "$PSScriptRoot"
& docker build -f Dockerfile.nano -t nicholasdille/javaruntime:$($JavaVersion)-nano "$PSScriptRoot"

& docker tag nicholasdille/javaruntime:$($JavaVersion)-core nicholasdille/javaruntime:$JavaVersion
& docker tag nicholasdille/javaruntime:$($JavaVersion)-core nicholasdille/javaruntime:core
& docker tag nicholasdille/javaruntime:$($JavaVersion)-nano nicholasdille/javaruntime:nano
& docker tag nicholasdille/javaruntime:$JavaVersion nicholasdille/javaruntime:latest