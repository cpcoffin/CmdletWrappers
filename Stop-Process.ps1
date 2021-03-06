[CmdletBinding(DefaultParameterSetName='Id', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113412')]
param(
    [Parameter(ParameterSetName='Name', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('ProcessName')]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='Id', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [int[]]
    ${Id},

    [Parameter(ParameterSetName='InputObject', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [System.Diagnostics.Process[]]
    ${InputObject},

    [switch]
    ${PassThru},

    [ValidateNotNullOrEmpty()]
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Stop-Process', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Stop-Process
.ForwardHelpCategory Cmdlet

#>

