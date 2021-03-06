[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=135281', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [Alias('LN')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${LogName},

    [Parameter(Mandatory=$true, Position=1)]
    [Alias('SRC')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Source},

    [Parameter(Position=3)]
    [Alias('ET')]
    [ValidateSet('Error','Information','FailureAudit','SuccessAudit','Warning')]
    [ValidateNotNullOrEmpty()]
    [System.Diagnostics.EventLogEntryType]
    ${EntryType},

    [int16]
    ${Category},

    [Parameter(Mandatory=$true, Position=2)]
    [Alias('ID','EID')]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(0, 65535)]
    [int]
    ${EventId},

    [Parameter(Mandatory=$true, Position=4)]
    [Alias('MSG')]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(0, 32766)]
    [string]
    ${Message},

    [Alias('RD')]
    [ValidateNotNullOrEmpty()]
    [byte[]]
    ${RawData},

    [Alias('CN')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ComputerName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Write-EventLog', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Write-EventLog
.ForwardHelpCategory Cmdlet

#>

