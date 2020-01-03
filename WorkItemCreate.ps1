$witType="task"
$apiadress = "https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/workitems/`$$($witType)?api-version=5.1"
$personalAccessToken = "2ojzcqzxxmkn6hxrt7lhog3lgfgiqxjyi5u37tcn4334xi4ofi3a"
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))
$headers = @{authorization = "Basic $token" }
$body="[
{
`"op`": `"add`",
`"path`": `"/fields/System.Title`",
`"value`": `"InvokeAPIDeneme1`"
}
]"
Invoke-RestMethod -Uri $apiadress -Method Patch -Body $body -ContentType "application/json-patch+json" -Headers $headers