[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=394370')]
param(
    [Parameter(ParameterSetName='ByContent', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [string]
    ${Content},

    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=1)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, Position=1)]
    [string]
    ${LiteralPath})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Get-CmsMessage', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Get-CmsMessage
.ForwardHelpCategory Cmdlet

#>

