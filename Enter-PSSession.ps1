[CmdletBinding(DefaultParameterSetName='ComputerName', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135210', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='ComputerName', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ComputerName},

    [Parameter(ParameterSetName='Session', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Runspaces.PSSession]
    ${Session},

    [Parameter(ParameterSetName='Uri', Position=1, ValueFromPipelineByPropertyName=$true)]
    [Alias('URI','CU')]
    [ValidateNotNullOrEmpty()]
    [uri]
    ${ConnectionUri},

    [Parameter(ParameterSetName='InstanceId', ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [guid]
    ${InstanceId},

    [Parameter(ParameterSetName='Id', Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [int]
    ${Id},

    [Parameter(ParameterSetName='Name', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='Uri')]
    [Parameter(ParameterSetName='ComputerName')]
    [switch]
    ${EnableNetworkAccess},

    [Parameter(ParameterSetName='VMId', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('VMGuid')]
    [ValidateNotNullOrEmpty()]
    [guid]
    ${VMId},

    [Parameter(ParameterSetName='VMName', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${VMName},

    [Parameter(ParameterSetName='VMId', Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Uri', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMName', Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='ContainerId', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${ContainerId},

    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Uri', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ContainerId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMName', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ConfigurationName},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Enter-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Enter-PSSession
.ForwardHelpCategory Cmdlet

#>

