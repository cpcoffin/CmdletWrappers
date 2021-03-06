[CmdletBinding(DefaultParameterSetName='File', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113417')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='File', Mandatory=$true, Position=0)]
    [string]
    ${FilePath},

    [Parameter(ParameterSetName='LiteralFile', Mandatory=$true)]
    [Alias('PSPath')]
    [string]
    ${LiteralPath},

    [Parameter(ParameterSetName='File')]
    [switch]
    ${Append},

    [Parameter(ParameterSetName='Variable', Mandatory=$true)]
    [string]
    ${Variable})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Tee-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Tee-Object
.ForwardHelpCategory Cmdlet

#>

