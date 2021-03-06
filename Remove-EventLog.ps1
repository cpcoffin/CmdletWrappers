[CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135248', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(Position=1)]
    [Alias('CN')]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='Default', Mandatory=$true, Position=0)]
    [Alias('LN')]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LogName},

    [Parameter(ParameterSetName='Source')]
    [Alias('SRC')]
    [ValidateNotNullOrEmpty()]
    [ValidateNotNull()]
    [string[]]
    ${Source})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Remove-EventLog', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Remove-EventLog
.ForwardHelpCategory Cmdlet

#>

