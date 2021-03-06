[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low', HelpUri='http://go.microsoft.com/fwlink/?LinkID=144299')]
param(
    [Parameter(Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [switch]
    ${Force},

    [switch]
    ${NoServiceRestart})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Disable-PSSessionConfiguration', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Disable-PSSessionConfiguration
.ForwardHelpCategory Cmdlet

#>

