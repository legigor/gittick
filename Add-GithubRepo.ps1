$path = Resolve-Path("~\.gittick")
$token = [IO.File]::ReadAllText($path)

$project = Get-Location | Split-Path -Leaf
$postRepo = @{
    "name"          = $project
    "has_issues"    = "false"
    "has_wiki"      = "false"
    "has_downloads" = "false"
}

$response = Invoke-RestMethod -Method Post -Uri ("https://api.github.com/user/repos?access_token=" + $token) -Body (ConvertTo-Json $postRepo)
$url = $response.ssh_url

git init
git remote add origin $url
