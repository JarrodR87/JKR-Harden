function New-LGPOEntry {
    <#
        .SYNOPSIS
            Creates a new LGPO Formatted Entry to add to a Registry.Pol File
        .DESCRIPTION
            Creates a block of Text suitable to add to an LGPO Export
        .PARAMETER Scope
            Computer or User Poliocy
        .PARAMETER Path
            Specific Policy Patrh
        .PARAMETER Policy
            Policy to Edit at the Path
        .PARAMETER Setting
            Setting for the Policy selected
        .EXAMPLE
            New-LGPOEntry -Scope Computer -Path 'Software\Policies\Microsoft\Windows NT\Terminal Services' -Policy fAllowUnsolicitedFullControl -Setting 'DWORD:1'
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]$Scope,
        [Parameter(Mandatory = $true)]$Path,
        [Parameter(Mandatory = $true)]$Policy,
        [Parameter(Mandatory = $true)]$Setting
    ) 
    BEGIN { 

    } #BEGIN

    PROCESS {
        $LGPOEntry = "$Scope `n$Path `n$Policy `n$Setting"
    } #PROCESS

    END { 
        $LGPOEntry
    } #END

} #FUNCTION