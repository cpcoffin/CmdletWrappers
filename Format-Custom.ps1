[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=113301')]
param(
    [Parameter(Position=0)]
    [System.Object[]]
    ${Property},

    [ValidateRange(1, 2147483647)]
    [int]
    ${Depth},

    [System.Object]
    ${GroupBy},

    [string]
    ${View},

    [switch]
    ${ShowError},

    [switch]
    ${DisplayError},

    [switch]
    ${Force},

    [ValidateSet('CoreOnly','EnumOnly','Both')]
    [string]
    ${Expand},

    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Format-Custom', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Format-Custom
.ForwardHelpCategory Cmdlet

#>

