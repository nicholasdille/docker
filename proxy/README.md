# Introduction

Example of Linux container with proxy handling during build and run

# Building with a proxy

`docker build --build-arg PROXY=http://1.2.3.4:5678 ...`

# Running with a proxy

`docker run -e PROXY=http://1.2.3.4:5678 ...`