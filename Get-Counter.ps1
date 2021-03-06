[CmdletBinding(DefaultParameterSetName='GetCounterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=138335')]
param(
    [Parameter(ParameterSetName='ListSetSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [AllowEmptyCollection()]
    [string[]]
    ${ListSet},

    [Parameter(ParameterSetName='GetCounterSet', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyCollection()]
    [string[]]
    ${Counter},

    [Parameter(ParameterSetName='GetCounterSet')]
    [ValidateRange(1, 2147483647)]
    [int]
    ${SampleInterval},

    [Parameter(ParameterSetName='GetCounterSet')]
    [ValidateRange(1, 9223372036854775807)]
    [long]
    ${MaxSamples},

    [Parameter(ParameterSetName='GetCounterSet')]
    [switch]
    ${Continuous},

    [Alias('Cn')]
    [ValidateNotNull()]
    [AllowEmptyCollection()]
    [string[]]
    ${ComputerName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Diagnostics\Get-Counter', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Diagnostics\Get-Counter
.ForwardHelpCategory Cmdlet

#>

