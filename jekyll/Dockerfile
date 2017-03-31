#escape=`
FROM nicholasdille/ruby:2.3.1
MAINTAINER nicholas.dille@mailbox.org

SHELL [ "powershell", "-command" ]

RUN gem install jekyll github-pages tzinfo-data; `
    choco install -y git; `
    mkdir c:\site

ADD files /
WORKDIR c:\\site
ENTRYPOINT c:\entrypoint.ps1

EXPOSE 80
