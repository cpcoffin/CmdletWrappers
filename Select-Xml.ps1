[CmdletBinding(DefaultParameterSetName='Xml', HelpUri='http://go.microsoft.com/fwlink/?LinkID=135255')]
param(
    [Parameter(ParameterSetName='Path', Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='Xml', Mandatory=$true, Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Node')]
    [ValidateNotNullOrEmpty()]
    [System.Xml.XmlNode[]]
    ${Xml},

    [Parameter(ParameterSetName='Content', Mandatory=$true, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Content},

    [Parameter(Mandatory=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${XPath},

    [ValidateNotNullOrEmpty()]
    [hashtable]
    ${Namespace})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Select-Xml', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Select-Xml
.ForwardHelpCategory Cmdlet

#>

