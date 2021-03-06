[CmdletBinding(DefaultParameterSetName='Delimiter', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135201', RemotingCapability='None')]
param(
    [Parameter(ParameterSetName='Delimiter', Position=1)]
    [ValidateNotNullOrEmpty()]
    [ValidateNotNull()]
    [char]
    ${Delimiter},

    [Parameter(ParameterSetName='UseCulture', Mandatory=$true)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [switch]
    ${UseCulture},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [psobject[]]
    ${InputObject},

    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Header})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertFrom-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertFrom-Csv
.ForwardHelpCategory Cmdlet

#>

