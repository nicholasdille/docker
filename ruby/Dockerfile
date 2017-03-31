# escape=`
FROM microsoft/windowsservercore
MAINTAINER nicholas.dille@mailbox.org

SHELL [ "powershell", "-Command" ]

ENV RUBY_VERSION=2.3.1 `
    GEM_VERSION=2.6.11

# Install ruby
RUN Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); `
    choco install -y ruby --version=$env:RUBY_VERSION

# Install ruby devkit2
RUN choco install -y ruby2.devkit; `
    Set-Location -Path 'c:\tools\DevKit2'; `
    ruby dk.rb init; `
    '- c:\tools\ruby23' | Add-Content -Path 'c:\tools\DevKit2\config.yml'; `
    ruby dk.rb install

# Update gem manually due to SSL certificates:
# http://guides.rubygems.org/ssl-certificate-update/#installing-using-update-packages
RUN Invoke-WebRequest -UseBasicParsing -Uri "https://rubygems.org/gems/rubygems-update-$env:GEM_VERSION.gem" -OutFile 'c:\rubygems-update.gem'; `
    gem install --local C:\rubygems-update.gem; `
    update_rubygems --no-ri --no-rdoc; `
    gem uninstall rubygems-update -x

CMD [ "ruby", "--version" ]