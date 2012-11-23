$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\Jira -Force

$json = Get-JiraSearchResult 'fixVersion = "ILB Core Backlog" and Sprint in openSprints() and type in ("User Story", Defect) order by Rank'

Function ConvertTo-HoursFromSeconds($seconds) {
    #Return $seconds
    Return $seconds/60/60
}

Foreach ($issue in $json.issues) {
    #If ($issue.fields.aggregatetimeoriginalestimate -eq $Null) {
    #    Continue
    #}

    $detail = @{
        "key" = $issue.key
        "aggregatetimeestimate" = ConvertTo-HoursFromSeconds $issue.fields.aggregatetimeestimate
        "aggregatetimeoriginalestimate" = ConvertTo-HoursFromSeconds $issue.fields.aggregatetimeoriginalestimate
        "aggregatetimespent" = ConvertTo-HoursFromSeconds $issue.fields.aggregatetimespent
        "progress" = ConvertTo-HoursFromSeconds $issue.fields.aggregateprogress.progress
        "total" = ConvertTo-HoursFromSeconds $issue.fields.aggregateprogress.total
    }

    If ($detail["aggregatetimeoriginalestimate"] -eq 0) {
        Write-Host $detail['key'] "has no estimate"
        $detail
    }

    #$detail
}