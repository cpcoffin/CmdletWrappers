[CmdletBinding(DefaultParameterSetName='Version', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113450')]
param(
    [Parameter(ParameterSetName='Off', Mandatory=$true)]
    [switch]
    ${Off},

    [Parameter(ParameterSetName='Version', Mandatory=$true)]
    [Alias('v')]
    [version]
    ${Version})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Set-StrictMode', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Set-StrictMode
.ForwardHelpCategory Cmdlet

#>

