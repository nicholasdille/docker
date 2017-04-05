$ErrorActionPreference = 'Stop'
#Set-PSDebug -Trace 1

#region Import registry definition
Import-LocalizedData -BaseDirectory "$PSScriptRoot" -FileName registry.psd1 -BindingVariable Registry
'Imported registry definition'
$Registry
#endregion

#region Login to Docker Hub
docker login -u $env:DOCKER_USER -p $env:DOCKER_PASS
#endregion

#region Enumerate directories with image definition
Get-ChildItem -Path "$PSScriptRoot" -File -Recurse -Filter 'image.psd1' | ForEach-Object {
    Write-Host "Processing $($_.DirectoryName)"

    #region Import image definition
    Import-LocalizedData -BaseDirectory $_.Directory -FileName image.psd1 -BindingVariable Image
    'Imported image definition'
    $Image
    #endregion

    #region Build image
    $param = @("build", "-t", "$($Image.Name):$($Image.Version)", "$($_.DirectoryName)")
    "docker $($param -join ' ')"
    & docker @param
    #endregion

    #region Build public image name
    $Repository = $Registry.User
    if ($Registry.Host) {
        $Repository = "$($Registry.Host)/$Repository"
    }
    #endregion

    #region Tag image with public name(s)
    foreach ($Tag in $Image.Tags) {
        $param = @("tag", "$($Image.Name):$($Image.Version)", "$Repository/$($Image.Name):$Tag")
        "docker $($param -join ' ')"
        & docker @param
    }
    #endregion

    #region Push image with public name(s)
    foreach ($Tag in $Image.Tags) {
        $param = @("push", "$Repository/$($Image.Name):$Tag")
        "docker $($param -join ' ')"
        & docker @param
    }
    #endregion
}
#endregion

#region Logout of Docker Hub
docker logout
#endregion