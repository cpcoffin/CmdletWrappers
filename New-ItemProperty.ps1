[CmdletBinding(DefaultParameterSetName='Path', SupportsShouldProcess=$true, ConfirmImpact='Medium', SupportsTransactions=$true, HelpUri='http://go.microsoft.com/fwlink/?LinkID=113354')]
param(
    [Parameter(ParameterSetName='Path', Mandatory=$true, Position=0)]
    [string[]]
    ${Path},

    [Parameter(ParameterSetName='LiteralPath', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath')]
    [string[]]
    ${LiteralPath},

    [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSProperty')]
    [string]
    ${Name},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Type')]
    [string]
    ${PropertyType},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [System.Object]
    ${Value},

    [switch]
    ${Force},

    [string]
    ${Filter},

    [string[]]
    ${Include},

    [string[]]
    ${Exclude},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential})


dynamicparam
{
    try {
        $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\New-ItemProperty', [System.Management.Automation.CommandTypes]::Cmdlet, $PSBoundParameters)
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\New-ItemProperty', [System.Management.Automation.CommandTypes]::Cmdlet)
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

.ForwardHelpTargetName Microsoft.PowerShell.Management\New-ItemProperty
.ForwardHelpCategory Cmdlet

#>

