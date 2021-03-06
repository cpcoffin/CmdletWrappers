[CmdletBinding(DefaultParameterSetName='Loaded', HelpUri='http://go.microsoft.com/fwlink/?LinkID=141552')]
param(
    [Parameter(ParameterSetName='Available', Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='Loaded', Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='PsSession', Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='CimSession', Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='Loaded', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Available', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='PsSession', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='CimSession', ValueFromPipelineByPropertyName=$true)]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedName},

    [Parameter(ParameterSetName='Loaded')]
    [Parameter(ParameterSetName='Available')]
    [switch]
    ${All},

    [Parameter(ParameterSetName='Available', Mandatory=$true)]
    [Parameter(ParameterSetName='PsSession')]
    [Parameter(ParameterSetName='CimSession')]
    [switch]
    ${ListAvailable},

    [Parameter(ParameterSetName='Available')]
    [Parameter(ParameterSetName='PsSession')]
    [string]
    ${PSEdition},

    [Parameter(ParameterSetName='Available')]
    [Parameter(ParameterSetName='PsSession')]
    [Parameter(ParameterSetName='CimSession')]
    [switch]
    ${Refresh},

    [Parameter(ParameterSetName='PsSession', Mandatory=$true)]
    [ValidateNotNull()]
    [System.Management.Automation.Runspaces.PSSession]
    ${PSSession},

    [Parameter(ParameterSetName='CimSession', Mandatory=$true)]
    [ValidateNotNull()]
    [CimSession]
    ${CimSession},

    [Parameter(ParameterSetName='CimSession')]
    [ValidateNotNull()]
    [uri]
    ${CimResourceUri},

    [Parameter(ParameterSetName='CimSession')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${CimNamespace})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-Module', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Get-Module
.ForwardHelpCategory Cmdlet

#>

