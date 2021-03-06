[CmdletBinding(DefaultParameterSetName='GetCounterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=138338')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='ListSetSet', Mandatory=$true)]
    [AllowEmptyCollection()]
    [string[]]
    ${ListSet},

    [Parameter(ParameterSetName='GetCounterSet')]
    [datetime]
    ${StartTime},

    [Parameter(ParameterSetName='GetCounterSet')]
    [datetime]
    ${EndTime},

    [Parameter(ParameterSetName='GetCounterSet')]
    [AllowEmptyCollection()]
    [string[]]
    ${Counter},

    [Parameter(ParameterSetName='SummarySet')]
    [switch]
    ${Summary},

    [Parameter(ParameterSetName='GetCounterSet')]
    [ValidateRange(1, 9223372036854775807)]
    [long]
    ${MaxSamples})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Diagnostics\Import-Counter', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Diagnostics\Import-Counter
.ForwardHelpCategory Cmdlet

#>

