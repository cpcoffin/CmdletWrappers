[CmdletBinding(DefaultParameterSetName='FileAndTest', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Path', ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${testFilePath},

    [Parameter(ParameterSetName='FileAndTest', ValueFromPipeline=$true)]
    [psobject[]]
    ${TestInfo},

    [Parameter(ParameterSetName='UseGetOperationTest')]
    [string[]]
    ${ModuleName},

    [Parameter(ParameterSetName='UseGetOperationTest')]
    [ValidateSet('Simple','Comprehensive')]
    [string[]]
    ${TestType},

    [switch]
    ${IncludePesterOutput})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Invoke-OperationValidation', [System.Management.Automation.CommandTypes]::Function)
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

.ForwardHelpTargetName Invoke-OperationValidation
.ForwardHelpCategory Function

#>

