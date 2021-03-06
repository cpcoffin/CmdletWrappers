[CmdletBinding(DefaultParameterSetName='SessionIdParameterSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=210611')]
param(
    [Parameter(ParameterSetName='JobParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Job[]]
    ${Job},

    [switch]
    ${Wait},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Resume-Job', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Resume-Job
.ForwardHelpCategory Cmdlet

#>

