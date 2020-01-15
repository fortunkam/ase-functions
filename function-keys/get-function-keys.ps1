#TODO: Replace these with your own values
$webAppname = "mffunction"
$resourceGroupName = "ase-functions"
$aseBaseUrl = "mfase.appserviceenvironment.net"
$apiBase = "https://$webAppName.scm.$aseBaseUrl"
$siteBase = "https://$webAppName.$aseBaseUrl"

# Get the publishing credentials for the function
function getKuduCreds($appName, $resourceGroup)
{
    $user = az webapp deployment list-publishing-profiles -n $appName -g $resourceGroup `
            --query "[?publishMethod=='MSDeploy'].userName" -o tsv

    $pass = az webapp deployment list-publishing-profiles -n $appName -g $resourceGroup `
            --query "[?publishMethod=='MSDeploy'].userPWD" -o tsv

    $pair = "$($user):$($pass)"
    return [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
}

# Get the bearer token (to work with the API calls)
function getBearerToken($apiBaseUrl, $kuduCreds)
{
    return Invoke-RestMethod -Uri "$apiBaseUrl/api/functions/admin/token" `
        -Headers @{Authorization=("Basic {0}" -f $kuduCreds)} `
        -Method GET
}

$creds = getKuduCreds $webAppname  $resourceGroupName
$jwt = getBearerToken $apiBase $creds

# Use the bearer token to get the master key
function getSystemKey($siteBaseUrl, $keyName, $jwt)
{
    $x = Invoke-RestMethod -Uri "$siteBaseUrl/admin/host/systemkeys/$keyName" `
    -Headers @{Authorization=("Bearer {0}" -f $jwt)} `
    -Method GET
    return $x
}
$masterHostKey = getSystemKey $siteBase "_master" $jwt
$masterHostKey | Select-Object -Property name,value | Format-Table

# If the you want the other host key (default) use this method
function getHostKeys($siteBaseUrl, $masterKey)
{
    $apiUrl = "$siteBaseUrl/admin/host/keys?code=$masterkey"
    $result = Invoke-WebRequest $apiUrl
    return $result`
}

$hostKeys = getHostKeys $siteBase $masterHostKey.value
$keysCode =  $hostKeys.Content | ConvertFrom-Json
$keysCode.keys | Format-Table

# Get the keys for a function
function getFunctionKeys($siteBaseUrl, $functionName, $masterKey)
{
    $apiUrl = "$siteBaseUrl/admin/functions/$functionName/keys?code=$masterkey"
    $result = Invoke-WebRequest $apiUrl
    return $result`
}

$functionKeys = getFunctionKeys $siteBase "Function1" $masterHostKey.value
$funcCode =  $functionKeys.Content | ConvertFrom-Json
#Get the first item in the 
$funcCode.keys | Format-Table

