[CmdletBinding(DefaultParameterSetName='Name', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=210604', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='Session', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Runspaces.PSSession[]]
    ${Session},

    [Parameter(ParameterSetName='ComputerNameGuid', Mandatory=$true)]
    [Parameter(ParameterSetName='ComputerName', Mandatory=$true, Position=0)]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerNameGuid', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ApplicationName},

    [Parameter(ParameterSetName='ConnectionUri', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerNameGuid', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ConnectionUriGuid', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ConfigurationName},

    [Parameter(ParameterSetName='ConnectionUriGuid', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ConnectionUri', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('URI','CU')]
    [ValidateNotNullOrEmpty()]
    [uri[]]
    ${ConnectionUri},

    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriGuid')]
    [switch]
    ${AllowRedirection},

    [Parameter(ParameterSetName='InstanceId', Mandatory=$true)]
    [Parameter(ParameterSetName='ConnectionUriGuid', Mandatory=$true)]
    [Parameter(ParameterSetName='ComputerNameGuid', Mandatory=$true)]
    [ValidateNotNull()]
    [guid[]]
    ${InstanceId},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='Name', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerNameGuid')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriGuid')]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='ComputerNameGuid')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriGuid')]
    [System.Management.Automation.Runspaces.AuthenticationMechanism]
    ${Authentication},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerNameGuid')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriGuid')]
    [string]
    ${CertificateThumbprint},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerNameGuid')]
    [ValidateRange(1, 65535)]
    [int]
    ${Port},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerNameGuid')]
    [switch]
    ${UseSSL},

    [Parameter(ParameterSetName='ComputerNameGuid')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriGuid')]
    [System.Management.Automation.Remoting.PSSessionOption]
    ${SessionOption},

    [Parameter(ParameterSetName='ConnectionUriGuid')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='Id')]
    [Parameter(ParameterSetName='ComputerNameGuid')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='Session')]
    [Parameter(ParameterSetName='Name')]
    [Parameter(ParameterSetName='InstanceId')]
    [int]
    ${ThrottleLimit},

    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [int[]]
    ${Id})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Connect-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Connect-PSSession
.ForwardHelpCategory Cmdlet

#>

