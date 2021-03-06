[CmdletBinding(DefaultParameterSetName='ParentSet', SupportsTransactions=$true, HelpUri='http://go.microsoft.com/fwlink/?LinkID=113404')]
param(
    [Parameter(ParameterSetName='ParentSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='LeafSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='QualifierSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='NoQualifierSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Parameter(ParameterSetName='IsAbsoluteSet', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralPathSet', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [Parameter(ParameterSetName='QualifierSet', Position=1, ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Qualifier},

    [Parameter(ParameterSetName='NoQualifierSet', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${NoQualifier},

    [Parameter(ParameterSetName='ParentSet', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Parent},

    [Parameter(ParameterSetName='LeafSet', ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Leaf},

    [switch]
    ${Resolve},

    [Parameter(ParameterSetName='IsAbsoluteSet')]
    [switch]
    ${IsAbsolute},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential})


dynamicparam
{
    try {
        $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Split-Path', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
        $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
        if ($dynamicParams.Length -gt 0)
        {
            $paramDictionary = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
            foreach ($param in $dynamicParams)
            {
                $param = $param.Value

                if(-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name))
                {
                    $dynParam = [Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
                    $paramDictionary.Add($param.Name, $dynParam)
                }
            }
            return $paramDictionary
        }
    } catch {
        throw
    }
}

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Split-Path', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\Split-Path
.ForwardHelpCategory Cmdlet

#>

