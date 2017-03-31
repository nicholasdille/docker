# Introduction

Container image with ruby serving as a base for jekyll

# TODO

## Why does the following not work?

```
RUN Install-PackageProvider -Name chocolatey -Force; `
    Set-PackageSource -Name chocolatey -Trusted; `
    Install-Package -Name ruby -RequiredVersion "$env:RUBY_VERSION"
```