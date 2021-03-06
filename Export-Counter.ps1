[CmdletBinding(DefaultParameterSetName='ExportCounterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=138337')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string]
    ${Path},

    [ValidateNotNull()]
    [string]
    ${FileFormat},

    [uint32]
    ${MaxSize},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Microsoft.PowerShell.Commands.GetCounter.PerformanceCounterSampleSet[]]
    ${InputObject},

    [switch]
    ${Force},

    [switch]
    ${Circular})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Diagnostics\Export-Counter', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Diagnostics\Export-Counter
.ForwardHelpCategory Cmdlet

#>

