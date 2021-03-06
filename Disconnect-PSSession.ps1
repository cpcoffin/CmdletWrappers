[CmdletBinding(DefaultParameterSetName='Session', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=210605', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='Session', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Runspaces.PSSession[]]
    ${Session},

    [Parameter(ParameterSetName='Name')]
    [Parameter(ParameterSetName='Session')]
    [Parameter(ParameterSetName='Id')]
    [Parameter(ParameterSetName='InstanceId')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${IdleTimeoutSec},

    [Parameter(ParameterSetName='Session')]
    [Parameter(ParameterSetName='Name')]
    [Parameter(ParameterSetName='Id')]
    [Parameter(ParameterSetName='InstanceId')]
    [System.Management.Automation.Runspaces.OutputBufferingMode]
    ${OutputBufferingMode},

    [Parameter(ParameterSetName='Session')]
    [Parameter(ParameterSetName='Name')]
    [Parameter(ParameterSetName='Id')]
    [Parameter(ParameterSetName='InstanceId')]
    [int]
    ${ThrottleLimit},

    [Parameter(ParameterSetName='InstanceId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [guid[]]
    ${InstanceId},

    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='Name', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Disconnect-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Disconnect-PSSession
.ForwardHelpCategory Cmdlet

#>

