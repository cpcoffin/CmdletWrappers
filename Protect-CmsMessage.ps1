[CmdletBinding(DefaultParameterSetName='ByContent', HelpUri='http://go.microsoft.com/fwlink/?LinkId=394373')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [System.Management.Automation.CmsMessageRecipient[]]
    ${To},

    [Parameter(ParameterSetName='ByContent', Mandatory=$true, Position=1, ValueFromPipeline=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [psobject]
    ${Content},

    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=1)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, Position=1)]
    [string]
    ${LiteralPath},

    [Parameter(Position=2)]
    [string]
    ${OutFile})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Protect-CmsMessage', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Protect-CmsMessage
.ForwardHelpCategory Cmdlet

#>

