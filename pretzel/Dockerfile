# escape=`
FROM microsoft/nanoserver

SHELL [ "powershell", "-Command" ]

ENV PRETZEL_VERSION=0.5.0
RUN Invoke-WebRequest `
        -UseBasicParsing `
        -Uri "https://github.com/Code52/pretzel/releases/download/v$env:PRETZEL_VERSION/Pretzel.$env:PRETZEL_VERSION.zip" `
        -OutFile '.\Pretzel.zip'; `
    
    Expand-Archive -Path '.\Pretzel.zip' -DestinationPath 'c:\Pretzel'