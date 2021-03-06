[CmdletBinding(DefaultParameterSetName='Default', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135217', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ParameterSetName='Default', Position=0)]
    [Alias('HFID')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Id},

    [Parameter(ParameterSetName='Description')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Description},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('CN','__Server','IPAddress')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-HotFix', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-HotFix
.ForwardHelpCategory Cmdlet

#>

