[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=135235', RemotingCapability='SupportedByCommand')]
param(
    [Alias('CRF')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${CategoryResourceFile},

    [Parameter(Position=2)]
    [Alias('CN')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(Mandatory=$true, Position=0)]
    [Alias('LN')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${LogName},

    [Alias('MRF')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${MessageResourceFile},

    [Alias('PRF')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ParameterResourceFile},

    [Parameter(Mandatory=$true, Position=1)]
    [Alias('SRC')]
    [ValidateNotNullOrEmpty()]
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\New-EventLog', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\New-EventLog
.ForwardHelpCategory Cmdlet

#>

