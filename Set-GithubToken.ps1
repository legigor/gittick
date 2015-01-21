$ghLogin = Read-Host -Prompt "GitHub Login"

$ghPassResponse = Read-Host -Prompt "GitHub Password" -AsSecureString
$ghPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ghPassResponse))

$headers = @{
    "authorization" = "basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $ghLogin, $ghPass)))
}

function Create-Authorization(){

    # $headers
    $authorization = (ConvertTo-Json @{
         "note" = ("gittick for " + [Environment]::UserDomainName + "\" + [Environment]::UserName + "@" + $env:COMPUTERNAME)
         "scopes" = @("repo")
    })

    # $authorization

    $response = Invoke-RestMethod "https://api.github.com/authorizations" -me Post -h $headers -b $authorization
    $token = $response.token

    $token > "~\.gittick"
}

try {

    Create-Authorization
}
catch {
    $otp = $_.Exception.Response.Headers["X-GitHub-OTP"];
    if($otp -ne $null -and $otp.Contains("required")){
        
        $headers["X-GitHub-OTP"] = Read-Host -Prompt ("Authentication code ")
        Create-Authorization


    } else {

        throw

    }    
}
