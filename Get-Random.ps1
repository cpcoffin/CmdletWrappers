[CmdletBinding(DefaultParameterSetName='RandomNumberParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113446', RemotingCapability='None')]
param(
    [ValidateNotNull()]
    [System.Nullable[int]]
    ${SetSeed},

    [Parameter(ParameterSetName='RandomNumberParameterSet', Position=0)]
    [System.Object]
    ${Maximum},

    [Parameter(ParameterSetName='RandomNumberParameterSet')]
    [System.Object]
    ${Minimum},

    [Parameter(ParameterSetName='RandomListItemParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Object[]]
    ${InputObject},

    [Parameter(ParameterSetName='RandomListItemParameterSet')]
    [ValidateRange(1, 2147483647)]
    [int]
    ${Count})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-Random', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-Random
.ForwardHelpCategory Cmdlet

#>

