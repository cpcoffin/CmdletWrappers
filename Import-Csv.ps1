[CmdletBinding(DefaultParameterSetName='Delimiter', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113341')]
param(
    [Parameter(ParameterSetName='Delimiter', Position=1)]
    [ValidateNotNull()]
    [char]
    ${Delimiter},

    [Parameter(Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='UseCulture', Mandatory=$true)]
    [ValidateNotNull()]
    [switch]
    ${UseCulture},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Header},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Import-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Import-Csv
.ForwardHelpCategory Cmdlet

#>

