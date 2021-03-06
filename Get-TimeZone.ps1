[CmdletBinding(DefaultParameterSetName='Name', HelpUri='http://go.microsoft.com/fwlink/?LinkId=799468')]
param(
    [Parameter(ParameterSetName='Id', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Id},

    [Parameter(ParameterSetName='ListAvailable', Mandatory=$true)]
    [switch]
    ${ListAvailable},

    [Parameter(ParameterSetName='Name', Position=0, ValueFromPipeline=$true)]
    [string[]]
    ${Name})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-TimeZone', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-TimeZone
.ForwardHelpCategory Cmdlet

#>

