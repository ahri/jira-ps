$jira_api_base = "https://jira.isg.co.uk/rest/api/latest/"

Function ConvertTo-SafeUri($uri) {
    Return [System.Uri]::EscapeDataString($uri)
}

Function Set-JiraCredentials {
    Param(
        [Parameter(Mandatory=$True, Position=1)]
        [string]$username,

        [Parameter(Mandatory=$True, Position=2)]
        [System.Security.SecureString]$password
    )

    $env:JIRA_CREDENTIALS = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("${username}:$([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)))"))
}

Function Invoke-JiraRequest($method, $request) {
    If ($env:JIRA_CREDENTIALS -eq $Null) {
        Write-Error "No JIRA credentials have been set, please run ``Set-JiraCredentials'"
    }
    Write-Debug "Calling $method $jira_api_base$request with AUTH: Basic $env:JIRA_CREDENTIALS"
    Return Invoke-RestMethod -Uri "${jira_api_base}${request}" -Headers @{"AUTHORIZATION"="Basic $env:JIRA_CREDENTIALS"} -Method $method
}

Function Get-JiraIssue($issue) {
    Return Invoke-JiraRequest GET "issue/$(ConvertTo-SafeUri $issue)"
}

Function Get-JiraHistory($issue) {
    Return Invoke-JiraRequest GET "issue/$(ConvertTo-SafeUri $issue)?expand=changelog"
}

Function Get-JiraSearchResult($query) {
    Return Invoke-JiraRequest GET "search?jql=$(ConvertTo-SafeUri $query)"
}

Export-ModuleMember -Function Set-JiraCredentials,
                              ConvertTo-SafeUri,
                              Invoke-JiraQuery,
                              Get-JiraIssue,
                              Get-JiraHistory,
                              Get-JiraSearchResult