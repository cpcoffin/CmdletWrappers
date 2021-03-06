[CmdletBinding(DefaultParameterSetName='Name', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135277')]
param(
    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('PID','ProcessId')]
    [ValidateNotNullOrEmpty()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='Name', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('ProcessName')]
    [string[]]
    ${Name},

    [Parameter(Position=1)]
    [Alias('TimeoutSec')]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(0, 32767)]
    [int]
    ${Timeout},

    [Parameter(ParameterSetName='InputObject', Mandatory=$true, ValueFromPipeline=$true)]
    [System.Diagnostics.Process[]]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Wait-Process', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Wait-Process
.ForwardHelpCategory Cmdlet

#>

