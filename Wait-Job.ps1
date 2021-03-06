[CmdletBinding(DefaultParameterSetName='SessionIdParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113422')]
param(
    [Parameter(ParameterSetName='JobParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Job[]]
    ${Job},

    [switch]
    ${Any},

    [Alias('TimeoutSec')]
    [ValidateRange(-1, 2147483647)]
    [int]
    ${Timeout},

    [switch]
    ${Force},

    [Parameter(ParameterSetName='NameParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='InstanceIdParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [guid[]]
    ${InstanceId},

    [Parameter(ParameterSetName='SessionIdParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='StateParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [System.Management.Automation.JobState]
    ${State},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Wait-Job', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Wait-Job
.ForwardHelpCategory Cmdlet

#>

