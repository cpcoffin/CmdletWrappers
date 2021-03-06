[CmdletBinding(DefaultParameterSetName='Name', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkId=717984')]
param(
    [datetime]
    ${AccountExpires},

    [switch]
    ${AccountNeverExpires},

    [ValidateNotNull()]
    [ValidateLength(0, 48)]
    [string]
    ${Description},

    [ValidateNotNull()]
    [string]
    ${FullName},

    [Parameter(ParameterSetName='InputObject', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [Microsoft.PowerShell.Commands.LocalUser]
    ${InputObject},

    [Parameter(ParameterSetName='Name', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Name},

    [ValidateNotNull()]
    [securestring]
    ${Password},

    [bool]
    ${PasswordNeverExpires},

    [Parameter(ParameterSetName='SecurityIdentifier', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [System.Security.Principal.SecurityIdentifier]
    ${SID},

    [bool]
    ${UserMayChangePassword})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.LocalAccounts\Set-LocalUser', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.LocalAccounts\Set-LocalUser
.ForwardHelpCategory Cmdlet

#>

