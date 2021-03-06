[CmdletBinding(DefaultParameterSetName='BySource', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135247')]
param(
    [Parameter(ParameterSetName='BySource', Mandatory=$true, Position=0)]
    [string]
    ${SourceIdentifier},

    [Parameter(ParameterSetName='ByIdentifier', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [int]
    ${EventIdentifier})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Remove-Event', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Remove-Event
.ForwardHelpCategory Cmdlet

#>

