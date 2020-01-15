$apiadress = "https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/wiql?api-version=5.1"

$personalAccessToken ="2ojzcqzxxmkn6hxrt7lhog3lgfgiqxjyi5u37tcn4334xi4ofi3a"

$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"))

$headers = @{authorization = "Basic $token" }
 
$body= @"
{
  "query": "Select [System.Id], [System.Title], [System.State] from WorkItems where [System.TeamProject] = @project and [System.WorkItemType] = 'User Story'"
}
"@

$getWits = Invoke-RestMethod -Method Post -Uri $apiadress -Body $body -ContentType "application/json" -Headers $headers


foreach ($getwit in $getWits.workItems) {

  $witUrl = "https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/workitems/" + $getwit.id + '?$expand=fields'
  $witFields = Invoke-RestMethod -Method Get -Uri $witUrl -Headers $headers
  if($witFields.fields.'Microsoft.VSTS.Common.Risk'.Contains('High'))
  {
    $jsonBody = @(

      @{
          op = 'replace'
          path = '/fields/Microsoft.VSTS.Common.Risk'
          value =  '2 - Medium'
      }
             )
    
         $JSON = ConvertTo-Json $jsonBody
         $patchUrl = "https://dev.azure.com/kadriyetaylann/deneme/_apis/wit/workitems/" + $getwit.id + '?api-version=5.1'
         Invoke-RestMethod -Method Patch -Uri $patchUrl -Body $JSON -ContentType "application/json-patch+json; charset=utf-8" -Headers $headers  
            
  }

}
