$path = Split-Path ($MyInvocation.MyCommand.Definition) -Parent
Import-Module $path\Jira -Force

$workflow = "Reopened", "Open", "In Progress", "Resolved", "Tested"
$json = Get-JiraSearchResult 'fixVersion = "ILB Core Backlog" and Sprint in openSprints() and type in ("User Story", Defect) order by Rank'

Function Get-WorkflowIndex($status) {
    $idx = [Array]::IndexOf($workflow, $status)
    if ($idx -eq -1) {
        Write-Error "Unknown status: $status"
        Exit 1
    }
    Return $idx
}

Function Write-IssueTasks($issue) {
    Write-Host $issue.key + " " + $issue.fields.summary
    Foreach ($subtask in $issue.fields.subtasks) {
        "    " + $subtask.key + " " + $subtask.fields.status.name
    }
    Write-Host "_________________________"
    $issue.fields.status.name + " -> " + $workflow[$lcd]

    Write-Host
}

Foreach ($issue in $json.issues) {
    $issue_idx = Get-WorkflowIndex $issue.fields.status.name
    $lcd = $workflow.Count

    If ($issue.fields.subtasks.Count -eq 0) {
        Continue
    }

    Foreach ($subtask_status in $issue.fields.subtasks.fields.status.name) {
        $subtask_idx = Get-WorkflowIndex $subtask_status
        if ($subtask_idx -lt $lcd) {
            $lcd = $subtask_idx
        }
    }

    if (($lcd -ne $issue_idx) -and

        # Specifically exclude the situation where an issue is reopened and an open task exists
        !(($issue_idx -eq (Get-WorkflowIndex "Reopened")) -and
          ($lcd -eq (Get-WorkflowIndex "Open")))) {

        Write-IssueTasks $issue
    }
}