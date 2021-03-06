[CmdletBinding(DefaultParameterSetName='CredentialSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113311')]
param(
    [Parameter(ParameterSetName='CredentialSet', Mandatory=$true, Position=0)]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='MessageSet', Mandatory=$true)]
    [string]
    ${Message},

    [Parameter(ParameterSetName='MessageSet', Position=0)]
    [string]
    ${UserName})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Security\Get-Credential', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Security\Get-Credential
.ForwardHelpCategory Cmdlet

#>

