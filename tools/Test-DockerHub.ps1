function Test-DockerHubImage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $Namespace
        ,
        [Parameter(Mandatory)]
        [string]
        $Repository
        ,
        [Parameter()]
        [string]
        $Tag = 'latest'
    )

    $response = Invoke-WebRequest -Uri "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$Namespace/$($Repository):pull" -ErrorAction SilentlyContinue
    if ($response.StatusCode -ne 200) {
        return false
    }
    $token = $response.Content | ConvertFrom-Json | Select-Object -ExpandProperty token
    $response = Invoke-WebRequest -Uri "https://registry-1.docker.io/v2/$Namespace/$Repository/manifests/$Tag" -Headers @{Authorization = "Bearer $token"} -ErrorAction SilentlyContinue
    #[System.Text.Encoding]::ASCII.GetString($response.Content)
    return ($response.StatusCode -eq 200)
}