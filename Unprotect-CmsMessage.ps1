[CmdletBinding(DefaultParameterSetName='ByWinEvent', HelpUri='http://go.microsoft.com/fwlink/?LinkId=394374')]
param(
    [Parameter(ParameterSetName='ByContent', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [string]
    ${Content},

    [Parameter(ParameterSetName='ByWinEvent', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [PSTypeName('System.Diagnostics.Eventing.Reader.EventLogRecord')]
    [psobject]
    ${EventLogRecord},

    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=0)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, Position=0)]
    [string]
    ${LiteralPath},

    [switch]
    ${IncludeContext},

    [Parameter(Position=1)]
    [System.Management.Automation.CmsMessageRecipient[]]
    ${To})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Unprotect-CmsMessage', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Unprotect-CmsMessage
.ForwardHelpCategory Cmdlet

#>

