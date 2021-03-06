[CmdletBinding(DefaultParameterSetName='Secure', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113291')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${String},

    [Parameter(ParameterSetName='PlainText', Position=1)]
    [switch]
    ${AsPlainText},

    [Parameter(ParameterSetName='PlainText', Position=2)]
    [switch]
    ${Force},

    [Parameter(ParameterSetName='Secure', Position=1)]
    [securestring]
    ${SecureKey},

    [Parameter(ParameterSetName='Open')]
    [byte[]]
    ${Key})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\ConvertTo-SecureString', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\ConvertTo-SecureString
.ForwardHelpCategory Cmdlet

#>

