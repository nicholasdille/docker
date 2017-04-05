$ErrorActionPreference = 'Stop'
#Set-PSDebug -Trace 1

if (-Not (Test-Path -Path Env:\DOCKER_USER)) {
    Write-Error 'Missing environment variable DOCKER_USER'
}
if (-Not (Test-Path -Path Env:\DOCKER_PASS)) {
    Write-Error 'Missing environment variable DOCKER_PASS'
}

#region Import registry definition
Import-LocalizedData -BaseDirectory "$PSScriptRoot" -FileName registry.psd1 -BindingVariable Registry
'Imported registry definition'
$Registry
#endregion

#TODO: Only build changed images
$Files = Get-ChildItem -Path "$PSScriptRoot" -File -Recurse -Filter 'image.psd1'
if ($Files.Length -eq 0) {
    return
}

$Images = @{}
foreach ($File in $Files) {
    $Images[$File.Directory.BaseName] = Import-LocalizedData -BaseDirectory $File.Directory -FileName image.psd1
    $Images[$File.Directory.BaseName].DirectoryName = $File.DirectoryName
}

#region Login to Docker Hub
docker login -u $env:DOCKER_USER -p $env:DOCKER_PASS
#endregion

while ($Images.Count -gt 0) {
    $ImageName = $Images.Keys | Get-Random
    $DependsOn = $Images[$ImageName].DependsOn
    "--- ImageName=$ImageName DependsOn=$DependsOn"
    If ($DependsOn.Length -gt 0 -and $Images.ContainsKey($DependsOn)) {
        '    Dependent image must be built first'

    } else {
        $Image = $Images[$ImageName]

        #region Build image
        $param = @("build", "-t", "$($Image.Name):$($Image.Version)", "$($Image.DirectoryName)")
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
        #endregion

        $Images.Remove($ImageName)
    }
}

return

#region Logout of Docker Hub
docker logout
#endregion