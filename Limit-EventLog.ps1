[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135227', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [Alias('LN')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LogName},

    [Alias('CN')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Alias('MRD')]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(1, 365)]
    [int]
    ${RetentionDays},

    [Alias('OFA')]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('OverwriteOlder','OverwriteAsNeeded','DoNotOverwrite')]
    [System.Diagnostics.OverflowAction]
    ${OverflowAction},

    [ValidateNotNullOrEmpty()]
    [long]
    ${MaximumSize})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Limit-EventLog', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Limit-EventLog
.ForwardHelpCategory Cmdlet

#>

