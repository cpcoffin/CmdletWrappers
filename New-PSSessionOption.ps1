[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=144305', RemotingCapability='None')]
param(
    [int]
    ${MaximumRedirection},

    [switch]
    ${NoCompression},

    [switch]
    ${NoMachineProfile},

    [ValidateNotNull()]
    [cultureinfo]
    ${Culture},

    [ValidateNotNull()]
    [cultureinfo]
    ${UICulture},

    [int]
    ${MaximumReceivedDataSizePerCommand},

    [int]
    ${MaximumReceivedObjectSize},

    [System.Management.Automation.Runspaces.OutputBufferingMode]
    ${OutputBufferingMode},

    [ValidateRange(0, 2147483647)]
    [int]
    ${MaxConnectionRetryCount},

    [ValidateNotNull()]
    [psprimitivedictionary]
    ${ApplicationArguments},

    [Alias('OpenTimeoutMSec')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${OpenTimeout},

    [Alias('CancelTimeoutMSec')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${CancelTimeout},

    [Alias('IdleTimeoutMSec')]
    [ValidateRange(-1, 2147483647)]
    [int]
    ${IdleTimeout},

    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.Remoting.ProxyAccessType]
    ${ProxyAccessType},

    [System.Management.Automation.Runspaces.AuthenticationMechanism]
    ${ProxyAuthentication},

    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${ProxyCredential},

    [switch]
    ${SkipCACheck},

    [switch]
    ${SkipCNCheck},

    [switch]
    ${SkipRevocationCheck},

    [Alias('OperationTimeoutMSec')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${OperationTimeout},

    [switch]
    ${NoEncryption},

    [switch]
    ${UseUTF16},

    [switch]
    ${IncludePortInSPN})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-PSSessionOption', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-PSSessionOption
.ForwardHelpCategory Cmdlet

#>

