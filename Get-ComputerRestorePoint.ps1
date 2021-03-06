[CmdletBinding(DefaultParameterSetName='ID', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135215')]
param(
    [Parameter(ParameterSetName='ID', Position=0)]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(1, 2147483647)]
    [int[]]
    ${RestorePoint},

    [Parameter(ParameterSetName='LastStatus', Mandatory=$true)]
    [ValidateNotNull()]
    [switch]
    ${LastStatus})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-ComputerRestorePoint', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-ComputerRestorePoint
.ForwardHelpCategory Cmdlet

#>

