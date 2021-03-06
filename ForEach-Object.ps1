[CmdletBinding(DefaultParameterSetName='ScriptBlockSet', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113300', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='ScriptBlockSet', ValueFromPipeline=$true)]
    [Parameter(ParameterSetName='PropertyAndMethodSet', ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='ScriptBlockSet')]
    [scriptblock]
    ${Begin},

    [Parameter(ParameterSetName='ScriptBlockSet', Mandatory=$true, Position=0)]
    [AllowNull()]
    [AllowEmptyCollection()]
    [scriptblock[]]
    ${Process},

    [Parameter(ParameterSetName='ScriptBlockSet')]
    [scriptblock]
    ${End},

    [Parameter(ParameterSetName='ScriptBlockSet', ValueFromRemainingArguments=$true)]
    [AllowNull()]
    [AllowEmptyCollection()]
    [scriptblock[]]
    ${RemainingScripts},

    [Parameter(ParameterSetName='PropertyAndMethodSet', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${MemberName},

    [Parameter(ParameterSetName='PropertyAndMethodSet', ValueFromRemainingArguments=$true)]
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\ForEach-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\ForEach-Object
.ForwardHelpCategory Cmdlet

#>

