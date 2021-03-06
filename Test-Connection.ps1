[CmdletBinding(DefaultParameterSetName='Default', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135266', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='Source')]
    [Parameter(ParameterSetName='Default')]
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

    [Alias('Size','Bytes','BS')]
    [ValidateRange(0, 65500)]
    [int]
    ${BufferSize},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('CN','IPAddress','__SERVER','Server','Destination')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [ValidateRange(1, 4294967295)]
    [int]
    ${Count},

    [Parameter(ParameterSetName='Source')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='Source', Mandatory=$true, Position=1)]
    [Alias('FCN','SRC')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Source},

    [System.Management.ImpersonationLevel]
    ${Impersonation},

    [Parameter(ParameterSetName='Source')]
    [Parameter(ParameterSetName='Default')]
    [ValidateRange(-2147483648, 1000)]
    [int]
    ${ThrottleLimit},

    [Alias('TTL')]
    [ValidateRange(1, 255)]
    [int]
    ${TimeToLive},

    [ValidateRange(1, 60)]
    [int]
    ${Delay},

    [Parameter(ParameterSetName='Quiet')]
    [switch]
    ${Quiet})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Test-Connection', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Test-Connection
.ForwardHelpCategory Cmdlet

#>

