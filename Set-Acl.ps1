[CmdletBinding(DefaultParameterSetName='ByPath', SupportsShouldProcess=$true, ConfirmImpact='Medium', SupportsTransactions=$true, HelpUri='http://go.microsoft.com/fwlink/?LinkID=113389')]
param(
    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='ByInputObject', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='ByInputObject', Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    [System.Object]
    ${AclObject},

    [Parameter(ParameterSetName='ByPath', Position=2, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='ByLiteralPath', Position=2, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${CentralAccessPolicy},

    [Parameter(ParameterSetName='ByPath')]
    [Parameter(ParameterSetName='ByLiteralPath')]
    [switch]
    ${ClearCentralAccessPolicy},

    [switch]
    ${Passthru},

    [string]
    ${Filter},

    [string[]]
    ${Include},

    [string[]]
    ${Exclude})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Set-Acl', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Set-Acl
.ForwardHelpCategory Cmdlet

#>

