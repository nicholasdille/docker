# Introduction

Generic Minecraft server for Windows containers

**This image does not contain a Minecraft server but it can be used to create one. It only takes care of starting and running the server**

Create your own Minecraft server container using the following `Dockerfile`:

```
FROM nicholasdille/minecraft
ADD spigot-1.11.2.jar /
```