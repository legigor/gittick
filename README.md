# gittick

The naive Github client that creates repository remotely using the current directory name.

## Usage

- `.\Set-GithubToken.ps1` store the predefined application token to the ~\.gittick file. Create one on the [Personal access tokens](https://github.com/settings/applications) page
- `.\Add-GithubRepo.ps1` inits a repo, creates another repo remotely using the directory name and adds it as a remote ref

