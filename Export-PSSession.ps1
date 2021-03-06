[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=135213')]
param(
    [Parameter(Mandatory=$true, Position=1)]
    [Alias('PSPath','ModuleName')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${OutputModule},

    [switch]
    ${Force},

    [ValidateSet('Unicode','UTF7','UTF8','ASCII','UTF32','BigEndianUnicode','Default','OEM')]
    [string]
    ${Encoding},

    [Parameter(Position=2)]
    [Alias('Name')]
    [string[]]
    ${CommandName},

    [switch]
    ${AllowClobber},

    [Alias('Args')]
    [AllowNull()]
    [AllowEmptyCollection()]
    [System.Object[]]
    ${ArgumentList},

    [Alias('Type')]
    [System.Management.Automation.CommandTypes]
    ${CommandType},

    [Alias('PSSnapin')]
    [ValidateNotNull()]
    [string[]]
    ${Module},

    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedModule},

    [Parameter(Position=3)]
    [string[]]
    ${FormatTypeName},

    [System.Security.Cryptography.X509Certificates.X509Certificate2]
    ${Certificate},

    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNull()]
    [System.Management.Automation.Runspaces.PSSession]
    ${Session})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Export-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Export-PSSession
.ForwardHelpCategory Cmdlet

#>

