$apiadress = "https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/wiql?api-version=5.1"
$personalAccessToken ="2ojzcqzxxmkn6hxrt7lhog3lgfgiqxjyi5u37tcn4334xi4ofi3a"
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))
$headers = @{authorization = "Basic $token" }
$body= @"
{
"query": "SELECT
[System.Id],
[System.WorkItemType],
[System.Title],
[System.AssignedTo],
[System.State],
[System.Tags]
FROM workitems
WHERE
[System.TeamProject] = @project
AND [System.WorkItemType] = 'User Story'
AND [Microsoft.VSTS.Common.Risk] = '1 - High'"
}
"@
$getWits = Invoke-RestMethod -Method Post -Uri $apiadress -Body $body -ContentType "application/json" -Headers $headers
foreach ($getWit in $getWits.workItems) {
$witFieldsUrl = “https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/workitems/" + $getWit.id + ‘?$expand=fields’
$witFields = Invoke-RestMethod -Method Get -Uri $witFieldsUrl -Headers $headers
$witFields.fields.’System.Title’
}
