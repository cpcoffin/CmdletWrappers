[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=113303')]
param(
    [switch]
    ${AutoSize},

    [switch]
    ${HideTableHeaders},

    [switch]
    ${Wrap},

    [Parameter(Position=0)]
    [System.Object[]]
    ${Property},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Format-Table', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Format-Table
.ForwardHelpCategory Cmdlet

#>

