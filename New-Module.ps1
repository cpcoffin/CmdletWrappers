[CmdletBinding(DefaultParameterSetName='ScriptBlock', HelpUri='http://go.microsoft.com/fwlink/?LinkID=141554')]
param(
    [Parameter(ParameterSetName='Name', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [string]
    ${Name},

    [Parameter(ParameterSetName='ScriptBlock', Mandatory=$true, Position=0)]
    [Parameter(ParameterSetName='Name', Mandatory=$true, Position=1)]
    [ValidateNotNull()]
    [scriptblock]
    ${ScriptBlock},

    [ValidateNotNull()]
    [string[]]
    ${Function},

    [ValidateNotNull()]
    [string[]]
    ${Cmdlet},

    [switch]
    ${ReturnResult},

    [switch]
    ${AsCustomObject},

    [Parameter(ValueFromRemainingArguments=$true)]
    [Alias('Args')]
    [System.Object[]]
    ${ArgumentList})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\New-Module', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\New-Module
.ForwardHelpCategory Cmdlet

#>

