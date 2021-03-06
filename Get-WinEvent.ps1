[CmdletBinding(DefaultParameterSetName='GetLogSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=138336')]
param(
    [Parameter(ParameterSetName='ListLogSet', Mandatory=$true, Position=0)]
    [AllowEmptyCollection()]
    [string[]]
    ${ListLog},

    [Parameter(ParameterSetName='GetLogSet', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${LogName},

    [Parameter(ParameterSetName='ListProviderSet', Mandatory=$true, Position=0)]
    [AllowEmptyCollection()]
    [string[]]
    ${ListProvider},

    [Parameter(ParameterSetName='GetProviderSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${ProviderName},

    [Parameter(ParameterSetName='FileSet', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='FileSet')]
    [Parameter(ParameterSetName='GetProviderSet')]
    [Parameter(ParameterSetName='GetLogSet')]
    [Parameter(ParameterSetName='HashQuerySet')]
    [Parameter(ParameterSetName='XmlQuerySet')]
    [ValidateRange(1, 9223372036854775807)]
    [long]
    ${MaxEvents},

    [Parameter(ParameterSetName='GetProviderSet')]
    [Parameter(ParameterSetName='ListProviderSet')]
    [Parameter(ParameterSetName='ListLogSet')]
    [Parameter(ParameterSetName='GetLogSet')]
    [Parameter(ParameterSetName='HashQuerySet')]
    [Parameter(ParameterSetName='XmlQuerySet')]
    [Alias('Cn')]
    [ValidateNotNull()]
    [string]
    ${ComputerName},

    [Parameter(ParameterSetName='GetProviderSet')]
    [Parameter(ParameterSetName='ListProviderSet')]
    [Parameter(ParameterSetName='ListLogSet')]
    [Parameter(ParameterSetName='GetLogSet')]
    [Parameter(ParameterSetName='HashQuerySet')]
    [Parameter(ParameterSetName='XmlQuerySet')]
    [Parameter(ParameterSetName='FileSet')]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='FileSet')]
    [Parameter(ParameterSetName='GetProviderSet')]
    [Parameter(ParameterSetName='GetLogSet')]
    [ValidateNotNull()]
    [string]
    ${FilterXPath},

    [Parameter(ParameterSetName='XmlQuerySet', Mandatory=$true, Position=0)]
    [xml]
    ${FilterXml},

    [Parameter(ParameterSetName='HashQuerySet', Mandatory=$true, Position=0)]
    [hashtable[]]
    ${FilterHashtable},

    [Parameter(ParameterSetName='GetProviderSet')]
    [Parameter(ParameterSetName='ListLogSet')]
    [Parameter(ParameterSetName='GetLogSet')]
    [Parameter(ParameterSetName='HashQuerySet')]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='GetLogSet')]
    [Parameter(ParameterSetName='GetProviderSet')]
    [Parameter(ParameterSetName='FileSet')]
    [Parameter(ParameterSetName='HashQuerySet')]
    [Parameter(ParameterSetName='XmlQuerySet')]
    [switch]
    ${Oldest})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Diagnostics\Get-WinEvent', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Diagnostics\Get-WinEvent
.ForwardHelpCategory Cmdlet

#>

