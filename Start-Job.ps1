[CmdletBinding(DefaultParameterSetName='ComputerName', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113405')]
param(
    [Parameter(ParameterSetName='DefinitionName', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DefinitionName},

    [Parameter(ParameterSetName='DefinitionName', Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${DefinitionPath},

    [Parameter(ParameterSetName='DefinitionName', Position=2)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Type},

    [Parameter(ParameterSetName='ComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='FilePathComputerName', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='LiteralFilePathComputerName', ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='ComputerName', Mandatory=$true, Position=0)]
    [Alias('Command')]
    [scriptblock]
    ${ScriptBlock},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='LiteralFilePathComputerName')]
    [Parameter(ParameterSetName='FilePathComputerName')]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='FilePathComputerName', Mandatory=$true, Position=0)]
    [string]
    ${FilePath},

    [Parameter(ParameterSetName='LiteralFilePathComputerName', Mandatory=$true)]
    [Alias('PSPath')]
    [string]
    ${LiteralPath},

    [Parameter(ParameterSetName='FilePathComputerName')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='LiteralFilePathComputerName')]
    [System.Management.Automation.Runspaces.AuthenticationMechanism]
    ${Authentication},

    [Parameter(ParameterSetName='FilePathComputerName', Position=1)]
    [Parameter(ParameterSetName='ComputerName', Position=1)]
    [Parameter(ParameterSetName='LiteralFilePathComputerName', Position=1)]
    [scriptblock]
    ${InitializationScript},

    [Parameter(ParameterSetName='LiteralFilePathComputerName')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='FilePathComputerName')]
    [switch]
    ${RunAs32},

    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='LiteralFilePathComputerName')]
    [Parameter(ParameterSetName='FilePathComputerName')]
    [ValidateNotNullOrEmpty()]
    [version]
    ${PSVersion},

    [Parameter(ParameterSetName='FilePathComputerName', ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='ComputerName', ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='LiteralFilePathComputerName', ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='FilePathComputerName')]
    [Parameter(ParameterSetName='ComputerName')]
    [Parameter(ParameterSetName='LiteralFilePathComputerName')]
    [Alias('Args')]
    [System.Object[]]
    ${ArgumentList})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Start-Job', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Start-Job
.ForwardHelpCategory Cmdlet

#>

