[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkId=623708')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Path},

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

    [string[]]
    ${ScriptsToProcess},

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
    ${AssembliesToLoad})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-PSRoleCapabilityFile', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-PSRoleCapabilityFile
.ForwardHelpCategory Cmdlet

#>

