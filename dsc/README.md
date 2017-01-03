# Introduction

Windows Container [demonstrating the use of Powershell Desired State Configuration](http://dille.name/blog/2016/06/17/powershell-desired-state-configuration-psdsc-in-windows-containers-using-docker/)

# Creating the Image

`.\docker-build.cmd`

# Running the Container

`docker run -d --env nodename=configid nicholasdille/dsc`
