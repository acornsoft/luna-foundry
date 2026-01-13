param(
    [Parameter(Mandatory=$true)]
    [int[]]$Ids
)

$token = az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json-patch+json"
}

foreach ($id in $Ids) {
    $uri = "https://dev.azure.com/acornsoft/com.ecolab/_apis/wit/workitems/$id`?api-version=7.1"
    $wi = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
    $content = $wi.fields.'System.Description'
    $format = $wi.multilineFieldsFormat.'System.Description'
    if ($format -eq "html" -and $content -match '<.*>') {
        $markdown = $content | pandoc -f html -t markdown
    } else {
        $markdown = $content
    }
    $body = @{
        "multilineFieldsFormat" = @{
            "System.Description" = "markdown"
        }
        "operations" = @(
            @{
                "op" = "replace"
                "path" = "/fields/System.Description"
                "value" = $markdown
            }
        )
    }
    $json = $body | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri $uri -Method Patch -Body $json -Headers $headers
}