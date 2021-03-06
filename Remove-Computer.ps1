[CmdletBinding(DefaultParameterSetName='Local', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135246', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ParameterSetName='Local', Position=0)]
    [Parameter(ParameterSetName='Remote', Mandatory=$true)]
    [Alias('Credential')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${UnjoinDomainCredential},

    [Parameter(ParameterSetName='Remote')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${LocalCredential},

    [switch]
    ${Restart},

    [Parameter(ParameterSetName='Remote', ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${ComputerName},

    [switch]
    ${Force},

    [switch]
    ${PassThru},

    [ValidateNotNullOrEmpty()]
    [string]
    ${WorkgroupName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Remove-Computer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Remove-Computer
.ForwardHelpCategory Cmdlet

#>

