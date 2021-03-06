[CmdletBinding(DefaultParameterSetName='ByPath', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113297')]
param(
    [ValidateRange(1, 2147483647)]
    [int]
    ${Depth},

    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=0)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true)]
    [Alias('PSPath')]
    [string]
    ${LiteralPath},

    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [AllowNull()]
    [psobject]
    ${InputObject},

    [switch]
    ${Force},

    [Alias('NoOverwrite')]
    [switch]
    ${NoClobber},

    [ValidateSet('Unicode','UTF7','UTF8','ASCII','UTF32','BigEndianUnicode','Default','OEM')]
    [string]
    ${Encoding})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Export-Clixml', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Export-Clixml
.ForwardHelpCategory Cmdlet

#>

