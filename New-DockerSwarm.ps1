$ProxyString = '10.12.1.236:8083'

$Env:HTTP_PROXY = "http://$ProxyString"
$Env:HTTPS_PROXY = "https://$ProxyString"
$Env:NO_PROXY = '127.0.0.1,localhost,.172.,10.'

#https://github.com/docker/toolbox/releases/
$DockerToolboxVersion = '1.12.0-rc2'
If (-Not (Test-Path -Path "~\Downloads\DockerToolbox-$DockerToolboxVersion.exe")) {
    $IwrParams = @{ Proxy = $ProxyString }
    Invoke-WebRequest @IwrParams -Uri "https://github.com/docker/toolbox/releases/download/v$DockerToolboxVersion/DockerToolbox-$DockerToolboxVersion.exe" -OutFile "~\Downloads\DockerToolbox-$DockerToolboxVersion.exe"
}
If (-Not (Test-Path -Path "~\Downloads\DockerToolbox-$DockerToolboxVersion.exe")) {
    throw "Unable to download Docker Toolbox $DockerToolboxVersion"
}

$DockerToolboxPath = "$Env:ProgramFiles\Docker Toolbox"
If (-Not (Test-Path -Path $DockerToolboxPath)) {
    & ~\Downloads\DockerToolbox-$DockerToolboxVersion.exe /SILENT /COMPONENTS=docker,dockercompose,dockermachine
}
If (-Not (Test-Path -Path $DockerToolboxPath)) {
    throw "Installation of Docker Toolbox failed or wrong installation path ($DockerToolboxPath)"
}
#Set-Location -Path $DockerToolboxPath
$Env:PATH = "$Env:PATH;$DockerToolboxPath"

# create machines
# does not exist:
# $ docker-machine status manager
# Host does not exist: manager
# is running:
# $ docker-machine status manager
# Running
& docker-machine create --engine-env HTTP_PROXY=$Env:HTTP_PROXY --engine-env HTTPS_PROXY=$Env:HTTPS_PROXY --engine-env NO_PROXY=$Env:NO_PROXY -d hyperv --hyperv-cpu-count=2 --hyperv-memory=1024 manager
& docker-machine create --engine-env HTTP_PROXY=$Env:HTTP_PROXY --engine-env HTTPS_PROXY=$Env:HTTPS_PROXY --engine-env NO_PROXY=$Env:NO_PROXY -d hyperv --hyperv-cpu-count=2 --hyperv-memory=2048 agent1
& docker-machine create --engine-env HTTP_PROXY=$Env:HTTP_PROXY --engine-env HTTPS_PROXY=$Env:HTTPS_PROXY --engine-env NO_PROXY=$Env:NO_PROXY -d hyperv --hyperv-cpu-count=2 --hyperv-memory=2048 agent2

# select context of machine manager and create swarm token
& docker-machine env manager | Invoke-Expression
$SwarmToken = & docker run --rm swarm create
$SwarmToken | Set-Content -Path "~\Desktop\Swarm.txt"

# launch primary swarm manager
& docker run -d -p 3376:3376 -t -v /var/lib/boot2docker:/certs:ro swarm manage -H 0.0.0.0:3376 --tlsverify --tlscacert=/certs/ca.pem --tlscert=/certs/server.pem --tlskey=/certs/server-key.pem token://$SwarmToken

# add agent1 to swarm
& docker-machine env agent1 | Invoke-Expression
$AgentIp = & docker-machine ip agent1
& docker run -d swarm join --addr=$($AgentIp):2376 token://$SwarmToken

# add agent2 to swarm
& docker-machine env agent2 | Invoke-Expression
$AgentIp = & docker-machine ip agent2
& docker run -d swarm join --addr=$($AgentIp):2376 token://$SwarmToken

# set context to manager
& docker-machine env manager | Invoke-Expression
$Env:DOCKER_HOST="$(& docker-machine ip manager):3376"
& docker info