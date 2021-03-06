[CmdletBinding(DefaultParameterSetName='Name', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113399', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='Name', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('ServiceName','SN')]
    [string]
    ${Name},

    [Alias('DN')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DisplayName},

    [ValidateNotNullOrEmpty()]
    [string]
    ${Description},

    [Alias('StartMode','SM','ST')]
    [ValidateNotNullOrEmpty()]
    [System.ServiceProcess.ServiceStartMode]
    ${StartupType},

    [ValidateSet('Running','Stopped','Paused')]
    [string]
    ${Status},

    [Parameter(ParameterSetName='InputObject', ValueFromPipeline=$true)]
    [System.ServiceProcess.ServiceController]
    ${InputObject},

    [switch]
    ${PassThru})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Set-Service', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Set-Service
.ForwardHelpCategory Cmdlet

#>

