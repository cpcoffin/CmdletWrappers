[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135252')]
param(
    [ValidateNotNullOrEmpty()]
    [string]
    ${Server},

    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Reset-ComputerMachinePassword', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Reset-ComputerMachinePassword
.ForwardHelpCategory Cmdlet

#>

