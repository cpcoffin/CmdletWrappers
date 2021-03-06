[CmdletBinding(DefaultParameterSetName='ByPath', SupportsTransactions=$true, HelpUri='http://go.microsoft.com/fwlink/?LinkID=113305')]
param(
    [Parameter(ParameterSetName='ByPath', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='ByInputObject', Mandatory=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='ByLiteralPath', ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [switch]
    ${Audit},

    [switch]
    ${AllCentralAccessPolicies},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Get-Acl', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Get-Acl
.ForwardHelpCategory Cmdlet

#>

