[CmdletBinding(DefaultParameterSetName='Name', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135219', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='ComputerName', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerInstanceId', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerInstanceId', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ApplicationName},

    [Parameter(ParameterSetName='ConnectionUri', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ConnectionUriInstanceId', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('URI','CU')]
    [ValidateNotNullOrEmpty()]
    [uri[]]
    ${ConnectionUri},

    [Parameter(ParameterSetName='VMNameInstanceId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerInstanceId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ConnectionUri', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ConnectionUriInstanceId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ContainerId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ContainerIdInstanceId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMIdInstanceId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${ConfigurationName},

    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [switch]
    ${AllowRedirection},

    [Parameter(ParameterSetName='Name', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ContainerId')]
    [Parameter(ParameterSetName='VMId')]
    [Parameter(ParameterSetName='VMName')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='ContainerIdInstanceId', Mandatory=$true)]
    [Parameter(ParameterSetName='ConnectionUriInstanceId', Mandatory=$true)]
    [Parameter(ParameterSetName='InstanceId', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ComputerInstanceId', Mandatory=$true)]
    [Parameter(ParameterSetName='VMIdInstanceId', Mandatory=$true)]
    [Parameter(ParameterSetName='VMNameInstanceId', Mandatory=$true)]
    [ValidateNotNull()]
    [guid[]]
    ${InstanceId},

    [Parameter(ParameterSetName='ComputerInstanceId')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerInstanceId')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [System.Management.Automation.Runspaces.AuthenticationMechanism]
    ${Authentication},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerInstanceId')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [string]
    ${CertificateThumbprint},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerInstanceId')]
    [ValidateRange(1, 65535)]
    [int]
    ${Port},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerInstanceId')]
    [switch]
    ${UseSSL},

    [Parameter(ParameterSetName='ComputerInstanceId')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [int]
    ${ThrottleLimit},

    [Parameter(ParameterSetName='VMId')]
    [Parameter(ParameterSetName='ComputerInstanceId')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [Parameter(ParameterSetName='ContainerId')]
    [Parameter(ParameterSetName='ContainerIdInstanceId')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='VMIdInstanceId')]
    [Parameter(ParameterSetName='VMName')]
    [Parameter(ParameterSetName='VMNameInstanceId')]
    [Microsoft.PowerShell.Commands.SessionFilterState]
    ${State},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='ComputerInstanceId')]
    [Parameter(ParameterSetName='ConnectionUri')]
    [Parameter(ParameterSetName='ConnectionUriInstanceId')]
    [System.Management.Automation.Remoting.PSSessionOption]
    ${SessionOption},

    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='ContainerId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ContainerIdInstanceId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ContainerId},

    [Parameter(ParameterSetName='VMIdInstanceId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('VMGuid')]
    [ValidateNotNullOrEmpty()]
    [guid[]]
    ${VMId},

    [Parameter(ParameterSetName='VMNameInstanceId', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='VMName', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${VMName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Get-PSSession
.ForwardHelpCategory Cmdlet

#>

