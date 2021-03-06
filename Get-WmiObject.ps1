[CmdletBinding(DefaultParameterSetName='query', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113337', RemotingCapability='OwnedByCommand')]
param(
    [Parameter(ParameterSetName='query', Mandatory=$true, Position=0)]
    [Parameter(ParameterSetName='list', Position=1)]
    [Alias('ClassName')]
    [string]
    ${Class},

    [Parameter(ParameterSetName='list')]
    [switch]
    ${Recurse},

    [Parameter(ParameterSetName='query', Position=1)]
    [string[]]
    ${Property},

    [Parameter(ParameterSetName='query')]
    [string]
    ${Filter},

    [switch]
    ${Amended},

    [Parameter(ParameterSetName='WQLQuery')]
    [Parameter(ParameterSetName='query')]
    [switch]
    ${DirectRead},

    [Parameter(ParameterSetName='list')]
    [switch]
    ${List},

    [Parameter(ParameterSetName='WQLQuery', Mandatory=$true)]
    [string]
    ${Query},

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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-WmiObject', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Get-WmiObject
.ForwardHelpCategory Cmdlet

#>

