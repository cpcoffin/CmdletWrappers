[CmdletBinding(DefaultParameterSetName='RunspaceNameParameterSet', HelpUri='http://go.microsoft.com/fwlink/?LinkId=403734')]
param(
    [Parameter(ParameterSetName='RunspaceNameParameterSet', Position=0)]
    [string[]]
    ${RunspaceName},

    [Parameter(ParameterSetName='RunspaceParameterSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [runspace[]]
    ${Runspace},

    [Parameter(ParameterSetName='RunspaceIdParameterSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [int[]]
    ${RunspaceId},

    [Parameter(ParameterSetName='RunspaceInstanceIdParameterSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [guid[]]
    ${RunspaceInstanceId},

    [Parameter(ParameterSetName='ProcessNameParameterSet', Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ProcessName},

    [Parameter(ParameterSetName='ProcessNameParameterSet', Position=1)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${AppDomainName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-RunspaceDebug', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-RunspaceDebug
.ForwardHelpCategory Cmdlet

#>

