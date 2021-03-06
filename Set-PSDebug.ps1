[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=113398')]
param(
    [Parameter(ParameterSetName='on')]
    [ValidateRange(0, 2)]
    [int]
    ${Trace},

    [Parameter(ParameterSetName='on')]
    [switch]
    ${Step},

    [Parameter(ParameterSetName='on')]
    [switch]
    ${Strict},

    [Parameter(ParameterSetName='off')]
    [switch]
    ${Off})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Set-PSDebug', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Set-PSDebug
.ForwardHelpCategory Cmdlet

#>

