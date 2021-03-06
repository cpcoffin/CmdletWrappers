[CmdletBinding(DefaultParameterSetName='File', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113388')]
param(
    [Parameter(ParameterSetName='Object', Mandatory=$true, ValueFromPipeline=$true)]
    [AllowNull()]
    [AllowEmptyString()]
    [psobject]
    ${InputObject},

    [Parameter(Mandatory=$true, Position=0)]
    [string[]]
    ${Pattern},

    [Parameter(ParameterSetName='File', Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralFile', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [switch]
    ${SimpleMatch},

    [switch]
    ${CaseSensitive},

    [switch]
    ${Quiet},

    [switch]
    ${List},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Include},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Exclude},

    [switch]
    ${NotMatch},

    [switch]
    ${AllMatches},

    [ValidateNotNullOrEmpty()]
    [ValidateSet('unicode','utf7','utf8','utf32','ascii','bigendianunicode','default','oem')]
    [string]
    ${Encoding},

    [ValidateNotNullOrEmpty()]
    [ValidateCount(1, 2)]
    [ValidateRange(0, 2147483647)]
    [int[]]
    ${Context})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Select-String', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Select-String
.ForwardHelpCategory Cmdlet

#>

