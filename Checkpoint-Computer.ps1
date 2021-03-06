[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=135197')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Description},

    [Parameter(Position=1)]
    [Alias('RPT')]
    [ValidateSet('APPLICATION_INSTALL','APPLICATION_UNINSTALL','DEVICE_DRIVER_INSTALL','MODIFY_SETTINGS','CANCELLED_OPERATION')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${RestorePointType})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Checkpoint-Computer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Checkpoint-Computer
.ForwardHelpCategory Cmdlet

#>

