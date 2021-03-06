[CmdletBinding(DefaultParameterSetName='NameParameterSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=144306')]
param(
    [Alias('PA')]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('x86','amd64')]
    [string]
    ${ProcessorArchitecture},

    [Parameter(ParameterSetName='NameParameterSet')]
    [System.Management.Automation.Runspaces.PSSessionType]
    ${SessionType},

    [Parameter(ParameterSetName='AssemblyNameParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='NameParameterSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='SessionConfigurationFile', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Name},

    [Parameter(ParameterSetName='AssemblyNameParameterSet', Mandatory=$true, Position=1)]
    [string]
    ${AssemblyName},

    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='AssemblyNameParameterSet')]
    [string]
    ${ApplicationBase},

    [Parameter(ParameterSetName='AssemblyNameParameterSet', Mandatory=$true, Position=2)]
    [string]
    ${ConfigurationTypeName},

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${RunAsCredential},

    [System.Threading.ApartmentState]
    ${ThreadApartmentState},

    [System.Management.Automation.Runspaces.PSThreadOptions]
    ${ThreadOptions},

    [System.Management.Automation.Runspaces.PSSessionConfigurationAccessMode]
    ${AccessMode},

    [switch]
    ${UseSharedProcess},

    [string]
    ${StartupScript},

    [AllowNull()]
    [System.Nullable[double]]
    ${MaximumReceivedDataSizePerCommandMB},

    [AllowNull()]
    [System.Nullable[double]]
    ${MaximumReceivedObjectSizeMB},

    [string]
    ${SecurityDescriptorSddl},

    [switch]
    ${ShowSecurityDescriptorUI},

    [switch]
    ${Force},

    [switch]
    ${NoServiceRestart},

    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='AssemblyNameParameterSet')]
    [Alias('PowerShellVersion')]
    [ValidateNotNullOrEmpty()]
    [version]
    ${PSVersion},

    [Parameter(ParameterSetName='AssemblyNameParameterSet')]
    [Parameter(ParameterSetName='NameParameterSet')]
    [System.Management.Automation.PSSessionTypeOption]
    ${SessionTypeOption},

    [System.Management.Automation.PSTransportOption]
    ${TransportOption},

    [Parameter(ParameterSetName='NameParameterSet')]
    [Parameter(ParameterSetName='AssemblyNameParameterSet')]
    [System.Object[]]
    ${ModulesToImport},

    [Parameter(ParameterSetName='SessionConfigurationFile', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Path})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Register-PSSessionConfiguration', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Register-PSSessionConfiguration
.ForwardHelpCategory Cmdlet

#>

