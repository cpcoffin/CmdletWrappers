[CmdletBinding(DefaultParameterSetName='Path', HelpUri='http://go.microsoft.com/fwlink/?LinkId=517145')]
param(
    [Parameter(ParameterSetName='Path', Mandatory=$true, Position=0)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='Stream', Mandatory=$true)]
    [System.IO.Stream]
    ${InputStream},

    [ValidateSet('SHA1','SHA256','SHA384','SHA512','MACTripleDES','MD5','RIPEMD160')]
    [string]
    ${Algorithm})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Get-FileHash', [System.Management.Automation.CommandTypes]::Function)
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

.ForwardHelpTargetName Get-FileHash
.ForwardHelpCategory Function

#>

