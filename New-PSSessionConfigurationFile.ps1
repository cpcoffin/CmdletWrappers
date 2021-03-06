[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=217036')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Path},

    [ValidateNotNull()]
    [version]
    ${SchemaVersion},

    [guid]
    ${Guid},

    [string]
    ${Author},

    [string]
    ${Description},

    [string]
    ${CompanyName},

    [string]
    ${Copyright},

    [System.Management.Automation.Remoting.SessionType]
    ${SessionType},

    [string]
    ${TranscriptDirectory},

    [switch]
    ${RunAsVirtualAccount},

    [string[]]
    ${RunAsVirtualAccountGroups},

    [switch]
    ${MountUserDrive},

    [long]
    ${UserDriveMaximumSize},

    [string]
    ${GroupManagedServiceAccount},

    [string[]]
    ${ScriptsToProcess},

    [System.Collections.IDictionary]
    ${RoleDefinitions},

    [System.Collections.IDictionary]
    ${RequiredGroups},

    [System.Management.Automation.PSLanguageMode]
    ${LanguageMode},

    [Microsoft.PowerShell.ExecutionPolicy]
    ${ExecutionPolicy},

    [version]
    ${PowerShellVersion},

    [System.Object[]]
    ${ModulesToImport},

    [string[]]
    ${VisibleAliases},

    [System.Object[]]
    ${VisibleCmdlets},

    [System.Object[]]
    ${VisibleFunctions},

    [string[]]
    ${VisibleExternalCommands},

    [string[]]
    ${VisibleProviders},

    [System.Collections.IDictionary[]]
    ${AliasDefinitions},

    [System.Collections.IDictionary[]]
    ${FunctionDefinitions},

    [System.Object]
    ${VariableDefinitions},

    [System.Collections.IDictionary]
    ${EnvironmentVariables},

    [string[]]
    ${TypesToProcess},

    [string[]]
    ${FormatsToProcess},

    [string[]]
    ${AssembliesToLoad},

    [switch]
    ${Full})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-PSSessionConfigurationFile', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-PSSessionConfigurationFile
.ForwardHelpCategory Cmdlet

#>

