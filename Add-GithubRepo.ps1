
$path = Resolve-Path("~\.gittick")

$enc = [IO.File]::ReadAllText($path)
$pass = Read-Host -Prompt "Passphrase"

$encData = [Convert]::FromBase64String($enc)
$passData = [Text.Encoding]::Default.GetBytes($pass)

$tokenData = [Security.Cryptography.ProtectedData]::Unprotect($encData, $passData, "CurrentUser")
$token = [Text.Encoding]::Default.GetString($tokenData)

$response = Invoke-WebRequest ("https://api.github.com/user?access_token=" + $token)
$user = ($response.Content | ConvertFrom-Json).login

$project = Get-Location | Split-Path -Leaf

$postRepo = @{
    "name" = $project
}

$response = Invoke-WebRequest -Method Post -Uri ("https://api.github.com/user/repos?access_token=" + $token) -Body (ConvertTo-Json $postRepo)
$repo = ($response.Content | ConvertFrom-Json).ssh_url

git init
git remote add origin $repo
