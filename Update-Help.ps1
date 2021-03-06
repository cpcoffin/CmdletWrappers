[CmdletBinding(DefaultParameterSetName='Path', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=210614')]
param(
    [Parameter(ParameterSetName='LiteralPath', Position=0, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Path', Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('Name')]
    [ValidateNotNull()]
    [string[]]
    ${Module},

    [Parameter(ParameterSetName='LiteralPath', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Path', ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedModule},

    [Parameter(ParameterSetName='Path', Position=1)]
    [ValidateNotNull()]
    [string[]]
    ${SourcePath},

    [Parameter(ParameterSetName='LiteralPath', ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [ValidateNotNull()]
    [string[]]
    ${LiteralPath},

    [switch]
    ${Recurse},

    [Parameter(Position=2)]
    [ValidateNotNull()]
    [cultureinfo[]]
    ${UICulture},

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [switch]
    ${UseDefaultCredentials},

    [switch]
    ${Force})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Update-Help', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Update-Help
.ForwardHelpCategory Cmdlet

#>

