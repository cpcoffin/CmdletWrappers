[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=217469')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${ProviderName},

    [Parameter(Mandatory=$true, Position=1)]
    [int]
    ${Id},

    [byte]
    ${Version},

    [Parameter(Position=2)]
    [AllowEmptyCollection()]
    [System.Object[]]
    ${Payload})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Diagnostics\New-WinEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Diagnostics\New-WinEvent
.ForwardHelpCategory Cmdlet

#>

