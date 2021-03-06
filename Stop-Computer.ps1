[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135263', RemotingCapability='SupportedByCommand')]
param(
    [switch]
    ${AsJob},

    [Alias('Authentication')]
    [System.Management.AuthenticationLevel]
    ${DcomAuthentication},

    [ValidateSet('Default','Basic','Negotiate','CredSSP','Digest','Kerberos')]
    [string]
    ${WsmanAuthentication},

    [ValidateSet('DCOM','WSMan')]
    [string]
    ${Protocol},

    [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('CN','__SERVER','Server','IPAddress')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(Position=1)]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [System.Management.ImpersonationLevel]
    ${Impersonation},

    [ValidateRange(-2147483648, 1000)]
    [int]
    ${ThrottleLimit},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Stop-Computer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Stop-Computer
.ForwardHelpCategory Cmdlet

#>

