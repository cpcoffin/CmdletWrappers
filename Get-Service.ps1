[CmdletBinding(DefaultParameterSetName='Default', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113332', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ParameterSetName='Default', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('ServiceName')]
    [string[]]
    ${Name},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Alias('DS')]
    [switch]
    ${DependentServices},

    [Alias('SDO','ServicesDependedOn')]
    [switch]
    ${RequiredServices},

    [Parameter(ParameterSetName='DisplayName', Mandatory=$true)]
    [string[]]
    ${DisplayName},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Include},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Exclude},

    [Parameter(ParameterSetName='InputObject', ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [System.ServiceProcess.ServiceController[]]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-Service', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-Service
.ForwardHelpCategory Cmdlet

#>

