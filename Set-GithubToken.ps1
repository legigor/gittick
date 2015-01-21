$token = Read-Host -Prompt "GitHub Token"
$pass = Read-Host -Prompt "Passphrase"

$tokenData = [Text.Encoding]::Default.GetBytes($token)
$passData = [Text.Encoding]::Default.GetBytes($pass)

$encData = [Security.Cryptography.ProtectedData]::Protect($tokenData, $passData, "CurrentUser")

[Convert]::ToBase64String($encData) > "~\.gittick"