[CmdletBinding(DefaultParameterSetName='class', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113402', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='object', Mandatory=$true, ValueFromPipeline=$true)]
    [wmi]
    ${InputObject},

    [Parameter(ParameterSetName='path', Mandatory=$true)]
    [string]
    ${Path},

    [Parameter(ParameterSetName='class', Mandatory=$true, Position=0)]
    [string]
    ${Class},

    [Parameter(ParameterSetName='object')]
    [Parameter(ParameterSetName='class', Position=2)]
    [Parameter(ParameterSetName='path')]
    [Alias('Args','Property')]
    [hashtable]
    ${Arguments},

    [System.Management.PutType]
    ${PutType},

    [switch]
    ${AsJob},

    [Parameter(ParameterSetName='list')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='path')]
    [System.Management.ImpersonationLevel]
    ${Impersonation},

    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='list')]
    [System.Management.AuthenticationLevel]
    ${Authentication},

    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='list')]
    [string]
    ${Locale},

    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='list')]
    [switch]
    ${EnableAllPrivileges},

    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='list')]
    [string]
    ${Authority},

    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='list')]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [int]
    ${ThrottleLimit},

    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='list')]
    [Alias('Cn')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ComputerName},

    [Parameter(ParameterSetName='class')]
    [Parameter(ParameterSetName='path')]
    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='query')]
    [Parameter(ParameterSetName='list')]
    [Alias('NS')]
    [string]
    ${Namespace})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Set-WmiInstance', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Set-WmiInstance
.ForwardHelpCategory Cmdlet

#>

