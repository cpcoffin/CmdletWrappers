[CmdletBinding(DefaultParameterSetName='NameParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=403730')]
param(
    [Parameter(ParameterSetName='NameParameterSet', Position=0)]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='IdParameterSet', Mandatory=$true, Position=0)]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='InstanceIdParameterSet', Mandatory=$true, Position=0)]
    [guid[]]
    ${InstanceId})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-Runspace', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-Runspace
.ForwardHelpCategory Cmdlet

#>

