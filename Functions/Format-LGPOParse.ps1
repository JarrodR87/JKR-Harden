function Format-LGPOParse {
    <#
        .SYNOPSIS
            Formats Output of LGPO.exe into PowerShell Object
        .DESCRIPTION
            Converts the Parsed LGPO.exe data into a PowerShell Object to allow fo easy manipulation
        .PARAMETER LGPOData
            Source LGPO File or output from New-LGPOParse
        .EXAMPLE
            Format-LGPOParse -LGPOData (New-LGPOParse computer)
        .EXAMPLE
            Format-LGPOParse -LGPOData (New-LGPOParse user)
        .EXAMPLE
            Format-LGPOParse -LGPOData (Get-Content c:\LGPODATA.TXT)
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]$LGPOData
    ) 
    BEGIN { 
        $LGPO = $LGPOData | Where-Object -Filterscript { $_.trim() -ne "" } | select-Object -Skip 3 | select-Object -SkipLast 2

        $NumberofPolicies = @()
        1..(($LGPO.count) / 4) | ForEach-Object { $NumberofPolicies += $_.ToString("00") }

        $LGPOArray = @()
    } #BEGIN

    PROCESS {
        foreach ($Policy in $NumberofPolicies) {
            $LGPOObject = $LGPO | select-object -First 4


            $Scope = $LGPOObject[0]
            $Location = $LGPOObject[1]
            $Policy = $LGPOObject[2]
            $Setting = $LGPOObject[3]

            $Row = New-Object PSObject
            $Row | Add-Member -MemberType noteproperty -Name "Scope" -Value $Scope
            $Row | Add-Member -MemberType noteproperty -Name "Location" -Value $Location
            $Row | Add-Member -MemberType noteproperty -Name "Policy" -Value $Policy
            $Row | Add-Member -MemberType noteproperty -Name "Setting" -Value $Setting

            $LGPOArray += $Row

            $LGPO = $LGPO | select-Object -Skip 4
        }
    } #PROCESS

    END { 
        $LGPOArray
    } #END

} #FUNCTION