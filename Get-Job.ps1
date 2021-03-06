[CmdletBinding(DefaultParameterSetName='SessionIdParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113328')]
param(
    [Parameter(ParameterSetName='SessionIdParameterSet')]
    [Parameter(ParameterSetName='InstanceIdParameterSet')]
    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='StateParameterSet')]
    [Parameter(ParameterSetName='CommandParameterSet')]
    [switch]
    ${IncludeChildJob},

    [Parameter(ParameterSetName='SessionIdParameterSet')]
    [Parameter(ParameterSetName='InstanceIdParameterSet')]
    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='StateParameterSet')]
    [Parameter(ParameterSetName='CommandParameterSet')]
    [System.Management.Automation.JobState]
    ${ChildJobState},

    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='InstanceIdParameterSet')]
    [Parameter(ParameterSetName='SessionIdParameterSet')]
    [Parameter(ParameterSetName='StateParameterSet')]
    [Parameter(ParameterSetName='CommandParameterSet')]
    [bool]
    ${HasMoreData},

    [Parameter(ParameterSetName='SessionIdParameterSet')]
    [Parameter(ParameterSetName='InstanceIdParameterSet')]
    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='StateParameterSet')]
    [Parameter(ParameterSetName='CommandParameterSet')]
    [datetime]
    ${Before},

    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='InstanceIdParameterSet')]
    [Parameter(ParameterSetName='SessionIdParameterSet')]
    [Parameter(ParameterSetName='StateParameterSet')]
    [Parameter(ParameterSetName='CommandParameterSet')]
    [datetime]
    ${After},

    [Parameter(ParameterSetName='SessionIdParameterSet')]
    [Parameter(ParameterSetName='InstanceIdParameterSet')]
    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='StateParameterSet')]
    [Parameter(ParameterSetName='CommandParameterSet')]
    [int]
    ${Newest},

    [Parameter(ParameterSetName='SessionIdParameterSet', Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='NameParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='InstanceIdParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [guid[]]
    ${InstanceId},

    [Parameter(ParameterSetName='StateParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [System.Management.Automation.JobState]
    ${State},

    [Parameter(ParameterSetName='CommandParameterSet', ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Command},

    [Parameter(ParameterSetName='FilterParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [hashtable]
    ${Filter})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-Job', [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
<#

.ForwardHelpTargetName Microsoft.PowerShell.Core\Get-Job
.ForwardHelpCategory Cmdlet

#>

