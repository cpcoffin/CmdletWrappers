[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=210608', RemotingCapability='None')]
param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(60, 2147483)]
    [System.Nullable[int]]
    ${MaxIdleTimeoutSec},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(0, 1209600)]
    [System.Nullable[int]]
    ${ProcessIdleTimeoutSec},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 2147483647)]
    [System.Nullable[int]]
    ${MaxSessions},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 2147483647)]
    [System.Nullable[int]]
    ${MaxConcurrentCommandsPerSession},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 2147483647)]
    [System.Nullable[int]]
    ${MaxSessionsPerUser},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(5, 2147483647)]
    [System.Nullable[int]]
    ${MaxMemoryPerSessionMB},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 2147483647)]
    [System.Nullable[int]]
    ${MaxProcessesPerSession},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(1, 100)]
    [System.Nullable[int]]
    ${MaxConcurrentUsers},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(60, 2147483)]
    [System.Nullable[int]]
    ${IdleTimeoutSec},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [System.Nullable[System.Management.Automation.Runspaces.OutputBufferingMode]]
    ${OutputBufferingMode})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-PSTransportOption', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-PSTransportOption
.ForwardHelpCategory Cmdlet

#>

