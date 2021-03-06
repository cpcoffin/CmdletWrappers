[CmdletBinding(DefaultParameterSetName='GenericMeasure', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113349', RemotingCapability='None')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Property},

    [Parameter(ParameterSetName='GenericMeasure')]
    [switch]
    ${Sum},

    [Parameter(ParameterSetName='GenericMeasure')]
    [switch]
    ${Average},

    [Parameter(ParameterSetName='GenericMeasure')]
    [switch]
    ${Maximum},

    [Parameter(ParameterSetName='GenericMeasure')]
    [switch]
    ${Minimum},

    [Parameter(ParameterSetName='TextMeasure')]
    [switch]
    ${Line},

    [Parameter(ParameterSetName='TextMeasure')]
    [switch]
    ${Word},

    [Parameter(ParameterSetName='TextMeasure')]
    [switch]
    ${Character},

    [Parameter(ParameterSetName='TextMeasure')]
    [switch]
    ${IgnoreWhiteSpace})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Measure-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Measure-Object
.ForwardHelpCategory Cmdlet

#>

