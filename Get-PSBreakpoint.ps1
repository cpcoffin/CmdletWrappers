[CmdletBinding(DefaultParameterSetName='Script', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113325')]
param(
    [Parameter(ParameterSetName='Variable')]
    [Parameter(ParameterSetName='Command')]
    [Parameter(ParameterSetName='Type')]
    [Parameter(ParameterSetName='Script', Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [string[]]
    ${Script},

    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='Variable', Mandatory=$true)]
    [ValidateNotNull()]
    [string[]]
    ${Variable},

    [Parameter(ParameterSetName='Command', Mandatory=$true)]
    [ValidateNotNull()]
    [string[]]
    ${Command},

    [Parameter(ParameterSetName='Type', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.BreakpointType[]]
    ${Type})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-PSBreakpoint', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-PSBreakpoint
.ForwardHelpCategory Cmdlet

#>

