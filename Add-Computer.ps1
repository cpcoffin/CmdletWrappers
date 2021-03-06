[CmdletBinding(DefaultParameterSetName='Domain', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135194', RemotingCapability='SupportedByCommand')]
param(
    [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${LocalCredential},

    [Parameter(ParameterSetName='Domain')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${UnjoinDomainCredential},

    [Parameter(ParameterSetName='Workgroup')]
    [Parameter(ParameterSetName='Domain', Mandatory=$true)]
    [Alias('DomainCredential')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='Domain', Mandatory=$true, Position=0)]
    [Alias('DN','Domain')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DomainName},

    [Parameter(ParameterSetName='Domain')]
    [Alias('OU')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${OUPath},

    [Parameter(ParameterSetName='Domain')]
    [Alias('DC')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Server},

    [Parameter(ParameterSetName='Domain')]
    [switch]
    ${Unsecure},

    [Parameter(ParameterSetName='Domain')]
    [Microsoft.PowerShell.Commands.JoinOptions]
    ${Options},

    [Parameter(ParameterSetName='Workgroup', Mandatory=$true, Position=0)]
    [Alias('WGN')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${WorkgroupName},

    [switch]
    ${Restart},

    [switch]
    ${PassThru},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${NewName},

    [switch]
    ${Force})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Add-Computer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Add-Computer
.ForwardHelpCategory Cmdlet

#>

