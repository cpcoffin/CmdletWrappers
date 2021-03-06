[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkId=623636')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${Sddl},

    [ValidateSet('FileSystemRights','RegistryRights','ActiveDirectoryRights','MutexRights','SemaphoreRights','CryptoKeyRights','EventWaitHandleRights')]
    [System.Object]
    ${Type})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('ConvertFrom-SddlString', [System.Management.Automation.CommandTypes]::Function)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline()
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

.ForwardHelpTargetName ConvertFrom-SddlString
.ForwardHelpCategory Function

#>

