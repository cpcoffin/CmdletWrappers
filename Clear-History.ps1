[CmdletBinding(DefaultParameterSetName='IDParameter', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135199')]
param(
    [Parameter(ParameterSetName='IDParameter', Position=0, HelpMessage='Specifies the ID of a command in the session history.Clear history clears only the specified command')]
    [ValidateRange(1, 2147483647)]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='CommandLineParameter', HelpMessage='Specifies the name of a command in the session history')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${CommandLine},

    [Parameter(Position=1, HelpMessage='Clears the specified number of history entries')]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Count},

    [Parameter(HelpMessage='Specifies whether new entries to be cleared or the default old ones.')]
    [switch]
    ${Newest})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Clear-History', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Clear-History
.ForwardHelpCategory Cmdlet

#>

