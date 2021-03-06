[CmdletBinding(DefaultParameterSetName='net', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113313')]
param(
    [Parameter(Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('LastWriteTime')]
    [datetime]
    ${Date},

    [ValidateRange(1, 9999)]
    [int]
    ${Year},

    [ValidateRange(1, 12)]
    [int]
    ${Month},

    [ValidateRange(1, 31)]
    [int]
    ${Day},

    [ValidateRange(0, 23)]
    [int]
    ${Hour},

    [ValidateRange(0, 59)]
    [int]
    ${Minute},

    [ValidateRange(0, 59)]
    [int]
    ${Second},

    [ValidateRange(0, 999)]
    [int]
    ${Millisecond},

    [Microsoft.PowerShell.Commands.DisplayHintType]
    ${DisplayHint},

    [Parameter(ParameterSetName='UFormat')]
    [string]
    ${UFormat},

    [Parameter(ParameterSetName='net')]
    [string]
    ${Format})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-Date', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-Date
.ForwardHelpCategory Cmdlet

#>

