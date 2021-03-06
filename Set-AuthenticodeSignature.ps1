[CmdletBinding(DefaultParameterSetName='ByPath', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113391')]
param(
    [Parameter(Mandatory=$true, Position=1)]
    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${Certificate},

    [ValidateSet('signer','notroot','all')]
    [string]
    ${IncludeChain},

    [string]
    ${TimestampServer},

    [string]
    ${HashAlgorithm},

    [switch]
    ${Force},

    [Parameter(ParameterSetName='ByPath', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${FilePath},

    [Parameter(ParameterSetName='ByLiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='ByContent', Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${SourcePathOrExtension},

    [Parameter(ParameterSetName='ByContent', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [byte[]]
    ${Content})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Set-AuthenticodeSignature', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Set-AuthenticodeSignature
.ForwardHelpCategory Cmdlet

#>

