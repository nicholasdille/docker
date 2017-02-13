# Introduction

Windows Container with Java Runtime Environment (JRE)

# Versions

The script `docker-build.ps1` creates two images with the JRE - one is based on Windows Server Core and the other is based on NanoServer. They are tagged with 8u111-core and 8u111-nano assuming that 8u111 is the current version of the JRE.

The two builds are then tagged for your convenience:
- 8u111-core --> 8u111 --> latest
- 8u111-core --> core
- 8u111-nano --> nano