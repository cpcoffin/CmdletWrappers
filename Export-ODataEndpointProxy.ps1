[CmdletBinding(DefaultParameterSetName='CDXML', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='http://go.microsoft.com/fwlink/?LinkId=510069')]
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${Uri},

    [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${OutputModule},

    [Parameter(Position=2, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    ${MetadataUri},

    [Parameter(Position=3, ValueFromPipelineByPropertyName=$true)]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]
    ${Credential},

    [Parameter(Position=4, ValueFromPipelineByPropertyName=$true)]
    [ValidateSet('Put','Post','Patch')]
    [string]
    ${CreateRequestMethod},

    [Parameter(Position=5, ValueFromPipelineByPropertyName=$true)]
    [ValidateSet('Put','Post','Patch')]
    [string]
    ${UpdateRequestMethod},

    [Parameter(Position=6, ValueFromPipelineByPropertyName=$true)]
    [ValidateSet('ODataAdapter','NetworkControllerAdapter','ODataV4Adapter')]
    [string]
    ${CmdletAdapter},

    [Parameter(Position=7, ValueFromPipelineByPropertyName=$true)]
    [hashtable]
    ${ResourceNameMapping},

    [Parameter(Position=8, ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${Force},

    [Parameter(Position=9, ValueFromPipelineByPropertyName=$true)]
    [hashtable]
    ${CustomData},

    [Parameter(Position=10, ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${AllowClobber},

    [Parameter(Position=11, ValueFromPipelineByPropertyName=$true)]
    [switch]
    ${AllowUnsecureConnection},

    [Parameter(Position=12, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [hashtable]
    ${Headers})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Export-ODataEndpointProxy', [System.Management.Automation.CommandTypes]::Function)
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

.ForwardHelpTargetName Export-ODataEndpointProxy
.ForwardHelpCategory Function

#>

