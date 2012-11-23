JIRA PowerShell Toolkit
=======================

This is pretty rough at the moment and offers the bare minimum to be able to
construct PowerShell scripts that can access JIRA in a convenient manner.

You can use the toolkit in an interactive manner by importing the module to your
current environment:

    > cd .\jira-ps
    > Import-Module .\Jira

Set your JIRA credentials but note that these are insecurely stored in the Windows
Environment in base64 encoded form:

    > Set-JiraCredentials

cmdlet Set-JiraCredentials at command pipeline position 1
Supply values for the following parameters:
username: adam.piper
password:


Now you can use the provided Get-JiraIssue function:

    > Get-JiraIssue LCSIL-7212


    expand : renderedFields,names,schema,transitions,operations,editmeta,changelog
    id     : 742558
    self   : https://jira.isg.co.uk/rest/api/latest/issue/742558
    key    : LCSIL-7212
    fields : @{summary=Make ILB work under Windows 8; issuetype=; customfield_10233=; customfield_10232=;
             customfield_10235=; customfield_10234=; customfield_10240=; customfield_10241=; timespent=;
             customfield_10242=; reporter=; customfield_10237=; customfield_10236=; created=2012-11-09T10:51:54.000+0000;
             customfield_10239=; customfield_10238=; customfield_10040=; customfield_10395=; customfield_10397=;
             customfield_10255=; customfield_10252=; customfield_10391=; customfield_10253=; customfield_10250=;
             customfield_10251=; customfield_10390=; project=; customfield_10218=; customfield_10216=; customfield_10194=;
             customfield_10217=; customfield_10214=; customfield_10215=; customfield_10050=; components=System.Object[];
             comment=; timeoriginalestimate=; customfield_10307=; customfield_10306=; customfield_10159=;
             customfield_10303=40.0; customfield_10302=ILB generally works on Win 8; customfield_10305=;
             customfield_10304=; customfield_10261=; votes=; customfield_10262=; customfield_10263=;
             resolutiondate=2012-11-21T11:26:12.000+0000; customfield_10203=0.0; duedate=; watches=; worklog=;
             customfield_10100=; customfield_10591=; customfield_10592=; customfield_10593=; customfield_10594=;
             customfield_10274=; customfield_10690=1; customfield_10275=; customfield_10691=System.Object[];
             customfield_10590=; timeestimate=; customfield_10300=run ILB on Windows 8; customfield_10301=I can enjoy the
             pallid de-colourisation and beautiful transition animations whilst creating matters and recording time;
             customfield_10790=; customfield_10070=; progress=; timetracking=; customfield_10081=2012-11-21 11:26:12.0;
             customfield_10082=3_*:*_1_*:*_523755000_*|*_1_*:*_1_*:*_515103000_*|*_5_*:*_1_*:*_0; customfield_10140=;
             customfield_10491=; updated=2012-11-23T10:52:20.000+0000; description=; priority=;
             issuelinks=System.Object[]; customfield_10299=System.Object[]; subtasks=System.Object[]; status=;
             labels=System.Object[]; workratio=-1; customfield_10153=; customfield_10154=; environment=;
             customfield_10158=; aggregateprogress=; customfield_10011=; fixVersions=System.Object[]; resolution=;
             aggregatetimeoriginalestimate=; customfield_10120=; assignee=; attachment=System.Object[];
             aggregatetimeestimate=0; versions=System.Object[]; customfield_10131=; customfield_10030=;
             aggregatetimespent=126000}



Or the Get-JiraSearchResult function to provide a quesry in JQL:

    > Get-JiraSearchResult "id = LCSIL-7217"


    expand     : names,schema
    startAt    : 0
    maxResults : 50
    total      : 1
    issues     : {@{expand=editmeta,renderedFields,transitions,changelog,operations; id=742567;
                 self=https://jira.isg.co.uk/rest/api/latest/issue/742567; key=LCSIL-7217; fields=}}
