[CmdletBinding(DefaultParameterSetName='Name', HelpUri='http://go.microsoft.com/fwlink/?LinkID=141553')]
param(
    [switch]
    ${Global},

    [ValidateNotNull()]
    [string]
    ${Prefix},

    [Parameter(ParameterSetName='Name', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='PSSession', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='CimSession', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='FullyQualifiedName', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='FullyQualifiedNameAndPSSession', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedName},

    [Parameter(ParameterSetName='Assembly', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [System.Reflection.Assembly[]]
    ${Assembly},

    [ValidateNotNull()]
    [string[]]
    ${Function},

    [ValidateNotNull()]
    [string[]]
    ${Cmdlet},

    [ValidateNotNull()]
    [string[]]
    ${Variable},

    [ValidateNotNull()]
    [string[]]
    ${Alias},

    [switch]
    ${Force},

    [switch]
    ${PassThru},

    [switch]
    ${AsCustomObject},

    [Parameter(ParameterSetName='PSSession')]
    [Parameter(ParameterSetName='Name')]
    [Parameter(ParameterSetName='CimSession')]
    [Alias('Version')]
    [version]
    ${MinimumVersion},

    [Parameter(ParameterSetName='Name')]
    [Parameter(ParameterSetName='PSSession')]
    [Parameter(ParameterSetName='CimSession')]
    [string]
    ${MaximumVersion},

    [Parameter(ParameterSetName='CimSession')]
    [Parameter(ParameterSetName='PSSession')]
    [Parameter(ParameterSetName='Name')]
    [version]
    ${RequiredVersion},

    [Parameter(ParameterSetName='ModuleInfo', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [psmoduleinfo[]]
    ${ModuleInfo},

    [Alias('Args')]
    [System.Object[]]
    ${ArgumentList},

    [switch]
    ${DisableNameChecking},

    [Alias('NoOverwrite')]
    [switch]
    ${NoClobber},

    [ValidateSet('Local','Global')]
    [string]
    ${Scope},

    [Parameter(ParameterSetName='FullyQualifiedNameAndPSSession', Mandatory=$true)]
    [Parameter(ParameterSetName='PSSession', Mandatory=$true)]
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Import-Module', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Import-Module
.ForwardHelpCategory Cmdlet

#>

