[CmdletBinding(DefaultParameterSetName='RegularName', HelpUri='http://go.microsoft.com/fwlink/?LinkID=219983')]
param(
    [Parameter(ParameterSetName='RegularName', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='CanonicalName', Mandatory=$true)]
    [AllowNull()]
    [string[]]
    ${CanonicalName},

    [Parameter(ParameterSetName='ControlPanelItem', Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [Microsoft.PowerShell.Commands.ControlPanelItem[]]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Show-ControlPanelItem', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Show-ControlPanelItem
.ForwardHelpCategory Cmdlet

#>

