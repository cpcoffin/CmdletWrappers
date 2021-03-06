[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkID=135256')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [Alias('PsPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Attachments},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Bcc},

    [Parameter(Position=2)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Body},

    [Alias('BAH')]
    [switch]
    ${BodyAsHtml},

    [Alias('BE')]
    [ValidateNotNullOrEmpty()]
    [System.Text.Encoding]
    ${Encoding},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Cc},

    [Alias('DNO')]
    [ValidateNotNullOrEmpty()]
    [System.Net.Mail.DeliveryNotificationOptions]
    ${DeliveryNotificationOption},

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${From},

    [Parameter(Position=3)]
    [Alias('ComputerName')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${SmtpServer},

    [ValidateNotNullOrEmpty()]
    [System.Net.Mail.MailPriority]
    ${Priority},

    [Parameter(Mandatory=$true, Position=1)]
    [Alias('sub')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Subject},

    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${To},

    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [switch]
    ${UseSsl},

    [ValidateRange(0, 2147483647)]
    [int]
    ${Port})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Send-MailMessage', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Send-MailMessage
.ForwardHelpCategory Cmdlet

#>

