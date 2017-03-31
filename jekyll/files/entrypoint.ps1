if ($env:GIT_URL -and (Get-ChildItem -Path c:\site).Length -eq 0) {
    git clone $env:GIT_URL c:\site
}

if (Test-Path -Path c:\site\_config.yml) {
    & jekyll serve --future --no-watch --host 0.0.0.0 --port 80
}