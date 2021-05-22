function New-LGPOParse {
    <#
        .SYNOPSIS
            Uses LGPO.exe to Parse Local Group Policy Files
        .DESCRIPTION
            Parses User or Machine Local Group Policy
        .PARAMETER LGPOType
            Specifies User, Computer, or Machine Policy. Machine is the same as Computer as they both Query Machine Policy
        .EXAMPLE
            New-LGPOParse -LGPOType User
        .EXAMPLE
            New-LGPOParse -LGPOType Machine
        .EXAMPLE
            New-LGPOParse -LGPOType Computer
        .EXAMPLE
            New-LGPOParse -LGPOType File -PolPath <PATH TO POL>
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)][ValidateSet("Machine", "Computer", 'User', 'File')]$LGPOType,
        [Parameter()]$PolPath
    ) 
    BEGIN { 
        $ParentFolder = (Split-Path -Path $PSScriptRoot -Parent)
        $LGPOEXE = Join-Path $ParentFolder "LGPO.exe"

        If ($LGPOType -eq 'Machine') {
            if ((Test-Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol") -eq $False) {
                Write-Host 'No Machine Registry File Exists on this PC'
            }
            Else {
                $LGPOParse = $LGPOEXE + ' /q /parse /m c:\Windows\System32\GroupPolicy\Machine\Registry.pol'
            }
        }
        
        ElseIf ($LGPOType -eq 'Computer') {
            if ((Test-Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol") -eq $False) {
                Write-Host 'No Machine Registry File Exists on this PC'
            }
            Else {
                $LGPOParse = $LGPOEXE + ' /q /parse /m c:\Windows\System32\GroupPolicy\Machine\Registry.pol'
            }
        }
        Elseif ($LGPOType -eq 'User') {
            if ((Test-Path "C:\Windows\System32\GroupPolicy\User\Registry.pol") -eq $False) {
                Write-Host 'No User Registry File Exists on this PC'
            }
            Else {
                $LGPOParse = $LGPOEXE + ' /q /parse /m c:\Windows\System32\GroupPolicy\User\Registry.pol'
            }
        }   
        Elseif ($LGPOType -eq 'File') {
            if ($Null -eq $PolPath) {
                Write-Host 'Please Supply a value for the POL File to Parse'
            }
            Else {
                $LGPOParse = $LGPOEXE + " /q /parse /m $PolPath"
            }
        }
    } #BEGIN

    PROCESS {
        if ($Null -eq $LGPOParse) {
            Write-Host 'Malformed Command - Likely missing a Registry File'
        }
        Else {
            Invoke-Expression $LGPOParse -OutVariable output
        }
    } #PROCESS

    END { 

    } #END

} #FUNCTION