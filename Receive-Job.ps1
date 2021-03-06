[CmdletBinding(DefaultParameterSetName='Location', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113372', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ParameterSetName='ComputerName', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Session', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Location', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [System.Management.Automation.Job[]]
    ${Job},

    [Parameter(ParameterSetName='ComputerName', Position=1, ValueFromPipelineByPropertyName=$true)]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='Location', Position=1)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Location},

    [Parameter(ParameterSetName='Session', Position=1, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [System.Management.Automation.Runspaces.PSSession[]]
    ${Session},

    [switch]
    ${Keep},

    [switch]
    ${NoRecurse},

    [switch]
    ${Force},

    [switch]
    ${Wait},

    [switch]
    ${AutoRemoveJob},

    [switch]
    ${WriteEvents},

    [switch]
    ${WriteJobInResults},

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
    ${Id})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Receive-Job', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Receive-Job
.ForwardHelpCategory Cmdlet

#>

