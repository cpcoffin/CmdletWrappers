[CmdletBinding(DefaultParameterSetName='Secure', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113287')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [securestring]
    ${SecureString},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\ConvertFrom-SecureString', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\ConvertFrom-SecureString
.ForwardHelpCategory Cmdlet

#>

