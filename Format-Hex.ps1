[CmdletBinding(DefaultParameterSetName='Path', HelpUri='http://go.microsoft.com/fwlink/?LinkId=526919')]
param(
    [Parameter(ParameterSetName='Path', Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralPath', Mandatory=$true)]
    [Alias('PSPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='ByInputObject', Mandatory=$true, ValueFromPipeline=$true)]
    [System.Object]
    ${InputObject},

    [Parameter(ParameterSetName='ByInputObject')]
    [ValidateSet('Ascii','UTF32','UTF7','UTF8','BigEndianUnicode','Unicode')]
    [string]
    ${Encoding},

    [Parameter(ParameterSetName='ByInputObject')]
    [switch]
    ${Raw})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Format-Hex', [System.Management.Automation.CommandTypes]::Function)
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

.ForwardHelpTargetName Format-Hex
.ForwardHelpCategory Function

#>

