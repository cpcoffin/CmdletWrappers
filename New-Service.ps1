[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113359')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [Alias('ServiceName')]
    [string]
    ${Name},

    [Parameter(Mandatory=$true, Position=1)]
    [string]
    ${BinaryPathName},

    [ValidateNotNullOrEmpty()]
    [string]
    ${DisplayName},

    [ValidateNotNullOrEmpty()]
    [string]
    ${Description},

    [System.ServiceProcess.ServiceStartMode]
    ${StartupType},

    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [string[]]
    ${DependsOn})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\New-Service', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\New-Service
.ForwardHelpCategory Cmdlet

#>

