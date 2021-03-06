[CmdletBinding(DefaultParameterSetName='ByPath', HelpUri='http://go.microsoft.com/fwlink/?LinkID=623621')]
param(
    [Parameter(ParameterSetName='ByPath', Position=0)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='ByLiteralPath', ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Import-PowerShellDataFile', [System.Management.Automation.CommandTypes]::Function)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline()
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

.ForwardHelpTargetName Import-PowerShellDataFile
.ForwardHelpCategory Function

#>

