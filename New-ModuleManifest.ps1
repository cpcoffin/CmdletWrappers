[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=141555')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]
    ${Path},

    [AllowEmptyCollection()]
    [System.Object[]]
    ${NestedModules},

    [guid]
    ${Guid},

    [AllowEmptyString()]
    [string]
    ${Author},

    [AllowEmptyString()]
    [string]
    ${CompanyName},

    [AllowEmptyString()]
    [string]
    ${Copyright},

    [Alias('ModuleToProcess')]
    [AllowEmptyString()]
    [string]
    ${RootModule},

    [ValidateNotNull()]
    [version]
    ${ModuleVersion},

    [AllowEmptyString()]
    [string]
    ${Description},

    [System.Reflection.ProcessorArchitecture]
    ${ProcessorArchitecture},

    [version]
    ${PowerShellVersion},

    [version]
    ${ClrVersion},

    [version]
    ${DotNetFrameworkVersion},

    [string]
    ${PowerShellHostName},

    [version]
    ${PowerShellHostVersion},

    [System.Object[]]
    ${RequiredModules},

    [AllowEmptyCollection()]
    [string[]]
    ${TypesToProcess},

    [AllowEmptyCollection()]
    [string[]]
    ${FormatsToProcess},

    [AllowEmptyCollection()]
    [string[]]
    ${ScriptsToProcess},

    [AllowEmptyCollection()]
    [string[]]
    ${RequiredAssemblies},

    [AllowEmptyCollection()]
    [string[]]
    ${FileList},

    [AllowEmptyCollection()]
    [System.Object[]]
    ${ModuleList},

    [AllowEmptyCollection()]
    [string[]]
    ${FunctionsToExport},

    [AllowEmptyCollection()]
    [string[]]
    ${AliasesToExport},

    [AllowEmptyCollection()]
    [string[]]
    ${VariablesToExport},

    [AllowEmptyCollection()]
    [string[]]
    ${CmdletsToExport},

    [AllowEmptyCollection()]
    [string[]]
    ${DscResourcesToExport},

    [AllowEmptyCollection()]
    [ValidateSet('Desktop','Core')]
    [string[]]
    ${CompatiblePSEditions},

    [AllowNull()]
    [System.Object]
    ${PrivateData},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Tags},

    [ValidateNotNullOrEmpty()]
    [uri]
    ${ProjectUri},

    [ValidateNotNullOrEmpty()]
    [uri]
    ${LicenseUri},

    [ValidateNotNullOrEmpty()]
    [uri]
    ${IconUri},

    [ValidateNotNullOrEmpty()]
    [string]
    ${ReleaseNotes},

    [AllowNull()]
    [string]
    ${HelpInfoUri},

    [switch]
    ${PassThru},

    [AllowNull()]
    [string]
    ${DefaultCommandPrefix})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-ModuleManifest', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-ModuleManifest
.ForwardHelpCategory Cmdlet

#>

