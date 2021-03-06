[CmdletBinding(DefaultParameterSetName='Date', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113360', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='Date', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('LastWriteTime')]
    [datetime]
    ${Start},

    [Parameter(ParameterSetName='Date', Position=1, ValueFromPipelineByPropertyName=$true)]
    [datetime]
    ${End},

    [Parameter(ParameterSetName='Time')]
    [int]
    ${Days},

    [Parameter(ParameterSetName='Time')]
    [int]
    ${Hours},

    [Parameter(ParameterSetName='Time')]
    [int]
    ${Minutes},

    [Parameter(ParameterSetName='Time')]
    [int]
    ${Seconds})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\New-TimeSpan', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\New-TimeSpan
.ForwardHelpCategory Cmdlet

#>

