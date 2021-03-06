[CmdletBinding(DefaultParameterSetName='DefaultSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135253', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='AsJobSet')]
    [switch]
    ${AsJob},

    [Alias('Authentication')]
    [System.Management.AuthenticationLevel]
    ${DcomAuthentication},

    [System.Management.ImpersonationLevel]
    ${Impersonation},

    [Parameter(ParameterSetName='DefaultSet')]
    [ValidateSet('Default','Basic','Negotiate','CredSSP','Digest','Kerberos')]
    [string]
    ${WsmanAuthentication},

    [Parameter(ParameterSetName='DefaultSet')]
    [ValidateSet('DCOM','WSMan')]
    [string]
    ${Protocol},

    [Parameter(Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('CN','__SERVER','Server','IPAddress')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(Position=1)]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Alias('f')]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='AsJobSet')]
    [ValidateRange(-2147483648, 1000)]
    [int]
    ${ThrottleLimit},

    [Parameter(ParameterSetName='DefaultSet')]
    [switch]
    ${Wait},

    [Parameter(ParameterSetName='DefaultSet')]
    [Alias('TimeoutSec')]
    [ValidateRange(-1, 2147483647)]
    [int]
    ${Timeout},

    [Parameter(ParameterSetName='DefaultSet')]
    [Microsoft.PowerShell.Commands.WaitForServiceTypes]
    ${For},

    [Parameter(ParameterSetName='DefaultSet')]
    [ValidateRange(1, 32767)]
    [int16]
    ${Delay})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Restart-Computer', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Restart-Computer
.ForwardHelpCategory Cmdlet

#>

