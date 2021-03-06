[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113352')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [string]
    ${Value},

    [string]
    ${Description},

    [System.Management.Automation.ScopedItemOptions]
    ${Option},

    [switch]
    ${PassThru},

    [string]
    ${Scope},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\New-Alias', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\New-Alias
.ForwardHelpCategory Cmdlet

#>

