FROM nicholasdille/ruby:2.3.1
MAINTAINER nicholas.dille@mailbox.org

RUN gem install jekyll github-pages tzinfo-data
RUN mkdir c:\blog

WORKDIR c:\\blog
CMD jekyll serve --future --no-watch --port 80

EXPOSE 80
VOLUME c:\\blog
