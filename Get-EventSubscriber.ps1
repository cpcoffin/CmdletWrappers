[CmdletBinding(DefaultParameterSetName='BySource', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135155')]
param(
    [Parameter(ParameterSetName='BySource', Position=0, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${SourceIdentifier},

    [Parameter(ParameterSetName='ById', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('Id')]
    [int]
    ${SubscriptionId},

    [Parameter(Position=1)]
    [switch]
    ${Force})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-EventSubscriber', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-EventSubscriber
.ForwardHelpCategory Cmdlet

#>

