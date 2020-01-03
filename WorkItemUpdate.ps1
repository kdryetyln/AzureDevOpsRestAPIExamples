$apiadress = "https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/workitems/6?api-version=5.1"
$personalAccessToken ="kng3gqpbax6kpku7kc2h5zi532jwxfm75wfj3gdgwxuxkemplk3a"
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))
$headers = @{authorization = "Basic $token" }
$body="[
{
`"op`": `"replace`",
`"path`": `"/fields/System.State`",
`"value`": `"Active`"
}
]"
Invoke-RestMethod -Uri $apiadress -Method Patch -Body $body -ContentType "application/json-patch+json" -Headers $headers