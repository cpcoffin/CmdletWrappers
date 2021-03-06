[CmdletBinding(DefaultParameterSetName='FromSource', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135195')]
param(
    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Alias('Provider')]
    [ValidateNotNullOrEmpty()]
    [System.CodeDom.Compiler.CodeDomProvider]
    ${CodeDomProvider},

    [Parameter(ParameterSetName='FromLiteralPath')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromSource')]
    [Alias('CP')]
    [System.CodeDom.Compiler.CompilerParameters]
    ${CompilerParameters},

    [Parameter(ParameterSetName='FromSource', Mandatory=$true, Position=0)]
    [string]
    ${TypeDefinition},

    [Parameter(ParameterSetName='FromMember', Mandatory=$true, Position=0)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='FromMember', Mandatory=$true, Position=1)]
    [string[]]
    ${MemberDefinition},

    [Parameter(ParameterSetName='FromMember')]
    [Alias('NS')]
    [AllowNull()]
    [string]
    ${Namespace},

    [Parameter(ParameterSetName='FromMember')]
    [Alias('Using')]
    [string[]]
    ${UsingNamespace},

    [Parameter(ParameterSetName='FromPath', Mandatory=$true, Position=0)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='FromLiteralPath', Mandatory=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='FromAssemblyName', Mandatory=$true)]
    [Alias('AN')]
    [string[]]
    ${AssemblyName},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Microsoft.PowerShell.Commands.Language]
    ${Language},

    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [Alias('RA')]
    [string[]]
    ${ReferencedAssemblies},

    [Parameter(ParameterSetName='FromSource')]
    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [Alias('OA')]
    [string]
    ${OutputAssembly},

    [Parameter(ParameterSetName='FromMember')]
    [Parameter(ParameterSetName='FromPath')]
    [Parameter(ParameterSetName='FromLiteralPath')]
    [Parameter(ParameterSetName='FromSource')]
    [Alias('OT')]
    [Microsoft.PowerShell.Commands.OutputAssemblyType]
    ${OutputType},

    [switch]
    ${PassThru},

    [switch]
    ${IgnoreWarnings})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Add-Type', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Add-Type
.ForwardHelpCategory Cmdlet

#>

