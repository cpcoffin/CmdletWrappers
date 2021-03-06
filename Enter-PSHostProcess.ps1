[CmdletBinding(DefaultParameterSetName='ProcessIdParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkId=403736')]
param(
    [Parameter(ParameterSetName='ProcessParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [System.Diagnostics.Process]
    ${Process},

    [Parameter(ParameterSetName='ProcessIdParameterSet', Mandatory=$true, Position=0)]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Id},

    [Parameter(ParameterSetName='ProcessNameParameterSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Name},

    [Parameter(ParameterSetName='PSHostProcessInfoParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.PSHostProcessInfo]
    ${HostProcessInfo},

    [Parameter(ParameterSetName='PSHostProcessInfoParameterSet', Position=1)]
    [Parameter(ParameterSetName='ProcessIdParameterSet', Position=1)]
    [Parameter(ParameterSetName='ProcessNameParameterSet', Position=1)]
    [Parameter(ParameterSetName='ProcessParameterSet', Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${AppDomainName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Enter-PSHostProcess', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Enter-PSHostProcess
.ForwardHelpCategory Cmdlet

#>

