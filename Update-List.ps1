[CmdletBinding(DefaultParameterSetName='AddRemoveSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113447', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='AddRemoveSet')]
    [ValidateNotNullOrEmpty()]
    [System.Object[]]
    ${Add},

    [Parameter(ParameterSetName='AddRemoveSet')]
    [ValidateNotNullOrEmpty()]
    [System.Object[]]
    ${Remove},

    [Parameter(ParameterSetName='ReplaceSet', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Object[]]
    ${Replace},

    [Parameter(ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [psobject]
    ${InputObject},

    [Parameter(Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Property})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Update-List', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Update-List
.ForwardHelpCategory Cmdlet

#>

