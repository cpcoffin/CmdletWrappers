[CmdletBinding(DefaultParameterSetName='NoCredentials', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135238')]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [Alias('WL','WSDL','Path')]
    [ValidateNotNullOrEmpty()]
    [uri]
    ${Uri},

    [Parameter(Position=1)]
    [Alias('FileName','FN')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Class},

    [Parameter(Position=2)]
    [Alias('NS')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Namespace},

    [Parameter(ParameterSetName='Credential')]
    [Alias('Cred')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(ParameterSetName='UseDefaultCredential')]
    [Alias('UDC')]
    [ValidateNotNull()]
    [switch]
    ${UseDefaultCredential})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\New-WebServiceProxy', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\New-WebServiceProxy
.ForwardHelpCategory Cmdlet

#>

