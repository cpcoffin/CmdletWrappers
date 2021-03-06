[CmdletBinding(DefaultParameterSetName='JobParameterSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkId=330208')]
param(
    [Parameter(ParameterSetName='JobParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [System.Management.Automation.Job]
    ${Job},

    [Parameter(ParameterSetName='JobNameParameterSet', Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='JobIdParameterSet', Mandatory=$true, Position=0)]
    [int]
    ${Id},

    [Parameter(ParameterSetName='JobInstanceIdParameterSet', Mandatory=$true, Position=0)]
    [guid]
    ${InstanceId})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Debug-Job', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Debug-Job
.ForwardHelpCategory Cmdlet

#>

