[CmdletBinding(DefaultParameterSetName='Seconds', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113407')]
param(
    [Parameter(ParameterSetName='Seconds', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(0, 2147483)]
    [int]
    ${Seconds},

    [Parameter(ParameterSetName='Milliseconds', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Milliseconds})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Start-Sleep', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Start-Sleep
.ForwardHelpCategory Cmdlet

#>

