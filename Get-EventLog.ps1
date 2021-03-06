[CmdletBinding(DefaultParameterSetName='LogName', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113314', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ParameterSetName='LogName', Mandatory=$true, Position=0)]
    [Alias('LN')]
    [string]
    ${LogName},

    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='LogName')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Newest},

    [Parameter(ParameterSetName='LogName')]
    [ValidateNotNullOrEmpty()]
    [datetime]
    ${After},

    [Parameter(ParameterSetName='LogName')]
    [ValidateNotNullOrEmpty()]
    [datetime]
    ${Before},

    [Parameter(ParameterSetName='LogName')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${UserName},

    [Parameter(ParameterSetName='LogName', Position=1)]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(0, 9223372036854775807)]
    [long[]]
    ${InstanceId},

    [Parameter(ParameterSetName='LogName')]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(1, 2147483647)]
    [int[]]
    ${Index},

    [Parameter(ParameterSetName='LogName')]
    [Alias('ET')]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('Error','Information','FailureAudit','SuccessAudit','Warning')]
    [string[]]
    ${EntryType},

    [Parameter(ParameterSetName='LogName')]
    [Alias('ABO')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Source},

    [Parameter(ParameterSetName='LogName')]
    [Alias('MSG')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Message},

    [Parameter(ParameterSetName='LogName')]
    [switch]
    ${AsBaseObject},

    [Parameter(ParameterSetName='List')]
    [switch]
    ${List},

    [Parameter(ParameterSetName='List')]
    [switch]
    ${AsString})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-EventLog', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-EventLog
.ForwardHelpCategory Cmdlet

#>

