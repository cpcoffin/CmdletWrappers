[CmdletBinding(DefaultParameterSetName='ByDelimiter', HelpUri='http://go.microsoft.com/fwlink/?LinkID=507579')]
param(
    [Parameter(ParameterSetName='ByDelimiter')]
    [Alias('DEL')]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Delimiter},

    [Parameter(ParameterSetName='ByDelimiter')]
    [Alias('PN')]
    [string[]]
    ${PropertyNames},

    [Parameter(ParameterSetName='TemplateParsing')]
    [Alias('TF')]
    [string[]]
    ${TemplateFile},

    [Parameter(ParameterSetName='TemplateParsing')]
    [Alias('TC')]
    [string[]]
    ${TemplateContent},

    [Parameter(ParameterSetName='TemplateParsing')]
    [Alias('IE')]
    [switch]
    ${IncludeExtent},

    [Parameter(ParameterSetName='TemplateParsing')]
    [Alias('UT')]
    [switch]
    ${UpdateTemplate},

    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [AllowEmptyString()]
    [string]
    ${InputObject})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertFrom-String', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertFrom-String
.ForwardHelpCategory Cmdlet

#>

