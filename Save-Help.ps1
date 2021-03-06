[CmdletBinding(DefaultParameterSetName='Path', HelpUri='http://go.microsoft.com/fwlink/?LinkID=210612')]
param(
    [Parameter(ParameterSetName='Path', Mandatory=$true, Position=0)]
    [ValidateNotNull()]
    [string[]]
    ${DestinationPath},

    [Parameter(ParameterSetName='LiteralPath', Mandatory=$true)]
    [Alias('PSPath')]
    [ValidateNotNull()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='Path', Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='LiteralPath', Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Name')]
    [ValidateNotNull()]
    [psmoduleinfo[]]
    ${Module},

    [Parameter(ParameterSetName='LiteralPath', ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='Path', ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedModule},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Save-Help', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Save-Help
.ForwardHelpCategory Cmdlet

#>

