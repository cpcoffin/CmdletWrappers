[CmdletBinding(DefaultParameterSetName='CmdletSet', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113309')]
param(
    [Parameter(ParameterSetName='AllCommandSet', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='CmdletSet', ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Verb},

    [Parameter(ParameterSetName='CmdletSet', ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Noun},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('PSSnapin')]
    [string[]]
    ${Module},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Microsoft.PowerShell.Commands.ModuleSpecification[]]
    ${FullyQualifiedModule},

    [Parameter(ParameterSetName='AllCommandSet', ValueFromPipelineByPropertyName=$true)]
    [Alias('Type')]
    [System.Management.Automation.CommandTypes]
    ${CommandType},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [int]
    ${TotalCount},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Syntax},

    [switch]
    ${ShowCommandInfo},

    [Parameter(Position=1, ValueFromRemainingArguments=$true)]
    [Alias('Args')]
    [AllowNull()]
    [AllowEmptyCollection()]
    [System.Object[]]
    ${ArgumentList},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${All},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${ListImported},

    [ValidateNotNullOrEmpty()]
    [string[]]
    ${ParameterName},

    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.PSTypeName[]]
    ${ParameterType})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-Command', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Core\Get-Command
.ForwardHelpCategory Cmdlet

#>

