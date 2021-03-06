[CmdletBinding(HelpUri='http://go.microsoft.com/fwlink/?LinkId=528576')]
param(
    [Parameter(ParameterSetName='NativeSet', Mandatory=$true)]
    [Parameter(ParameterSetName='PowerShellSet')]
    [string[]]
    ${CommandName},

    [Parameter(ParameterSetName='PowerShellSet', Mandatory=$true)]
    [string]
    ${ParameterName},

    [Parameter(Mandatory=$true)]
    [AllowNull()]
    [scriptblock]
    ${ScriptBlock},

    [Parameter(ParameterSetName='NativeSet')]
    [switch]
    ${Native})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Register-ArgumentCompleter', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Register-ArgumentCompleter
.ForwardHelpCategory Cmdlet

#>

