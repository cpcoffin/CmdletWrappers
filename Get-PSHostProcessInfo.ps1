[CmdletBinding(DefaultParameterSetName='ProcessNameParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkId=517012')]
param(
    [Parameter(ParameterSetName='ProcessNameParameterSet', Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='ProcessParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Diagnostics.Process[]]
    ${Process},

    [Parameter(ParameterSetName='ProcessIdParameterSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [int[]]
    ${Id})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-PSHostProcessInfo', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Get-PSHostProcessInfo
.ForwardHelpCategory Cmdlet

#>

