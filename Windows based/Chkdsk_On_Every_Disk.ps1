$Drives = Get-Partition | Select DriveLetter,Type

foreach ($Drive in $Drives)
    { 
        if ($Drive.Type -eq 'Basic' -Or $Drive.Type -eq 'IFS')
            {
            ## Write-Host $Drive.DriveLetter $Drive.Type
               $Swap = $Drive.DriveLetter+':'
               chkdsk $Swap
            }
    }