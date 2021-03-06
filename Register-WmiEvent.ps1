[CmdletBinding(DefaultParameterSetName='class', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135245', RemotingCapability='OwnedByCommand')]
param(
    [Alias('NS')]
    [string]
    ${Namespace},

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ComputerName},

    [Parameter(ParameterSetName='class', Mandatory=$true, Position=0)]
    [string]
    ${Class},

    [Parameter(ParameterSetName='query', Mandatory=$true, Position=0)]
    [string]
    ${Query},

    [Alias('TimeoutMSec')]
    [long]
    ${Timeout},

    [Parameter(Position=100)]
    [string]
    ${SourceIdentifier},

    [Parameter(Position=101)]
    [scriptblock]
    ${Action},

    [psobject]
    ${MessageData},

    [switch]
    ${SupportEvent},

    [switch]
    ${Forward},

    [int]
    ${MaxTriggerCount})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Register-WmiEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Register-WmiEvent
.ForwardHelpCategory Cmdlet

#>

