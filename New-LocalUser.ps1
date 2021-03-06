[CmdletBinding(DefaultParameterSetName='Password', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkId=717981')]
param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [datetime]
    ${AccountExpires},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${AccountNeverExpires},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [ValidateLength(0, 48)]
    [string]
    ${Description},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Disabled},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [string]
    ${FullName},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1, 20)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='Password', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [securestring]
    ${Password},

    [Parameter(ParameterSetName='NoPassword', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${NoPassword},

    [Parameter(ParameterSetName='Password', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${PasswordNeverExpires},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${UserMayNotChangePassword})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.LocalAccounts\New-LocalUser', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.LocalAccounts\New-LocalUser
.ForwardHelpCategory Cmdlet

#>

