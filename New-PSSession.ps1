[CmdletBinding(DefaultParameterSetName='ComputerName', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135237', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='ComputerName', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='Uri', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMName', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='Session', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Runspaces.PSSession[]]
    ${Session},

    [string[]]
    ${Name},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='Session')]
    [Parameter(ParameterSetName='Uri')]
    [switch]
    ${EnableNetworkAccess},

    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Uri', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ContainerId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMName', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ConfigurationName},

    [Parameter(ParameterSetName='VMId', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('VMGuid')]
    [ValidateNotNullOrEmpty()]
    [guid[]]
    ${VMId},

    [Parameter(ParameterSetName='VMName', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${VMName},

    [Parameter(ParameterSetName='ContainerId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ContainerId},

    [Parameter(ParameterSetName='ContainerId')]
    [switch]
    ${RunAsAdministrator},

    [Parameter(ParameterSetName='ComputerName')]
    [ValidateRange(1, 65535)]
    [int]
    ${Port},

    [Parameter(ParameterSetName='ComputerName')]
    [switch]
    ${UseSSL},

    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ApplicationName},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='Session')]
    [Parameter(ParameterSetName='Uri')]
    [Parameter(ParameterSetName='ContainerId')]
    [Parameter(ParameterSetName='VMId')]
    [Parameter(ParameterSetName='VMName')]
    [int]
    ${ThrottleLimit},

    [Parameter(ParameterSetName='Uri', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('URI','CU')]
    [ValidateNotNullOrEmpty()]
    [uri[]]
    ${ConnectionUri},

    [Parameter(ParameterSetName='Uri')]
    [switch]
    ${AllowRedirection},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='Uri')]
    [ValidateNotNull()]
    [System.Management.Automation.Remoting.PSSessionOption]
    ${SessionOption},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='Uri')]
    [System.Management.Automation.Runspaces.AuthenticationMechanism]
    ${Authentication},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='Uri')]
    [string]
    ${CertificateThumbprint})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-PSSession
.ForwardHelpCategory Cmdlet

#>

