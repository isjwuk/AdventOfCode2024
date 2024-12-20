<#
.SYNOPSIS
    Day 2 of Advent of Code - Part 1
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    https://adventofcode.com/2024/day/2
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

#Read in the data
$InputData=(Get-Content .\day2.txt)

#A running total of Safe Reports
$SafeReports=0

#Loop Through Lines (Reports)
Foreach ($Report in $InputData){
    $Safe=$true # A Report is Safe until we decide it's not
    $LastLevel=$null # The Last Level
    $Direction=$null # The Last Direction
    #Loop through each level in the report
    foreach ($LevelString in $Report.Split(" ")){
        $Level=[Int16]$LevelString
        If ($null -eq $LastLevel) {
            #The first Level, so will always be safe
        } else {
            #A subsequent level. Test against the previous level
            if ($Level -eq $LastLevel -or [Math]::Abs($Level -$LastLevel) -gt 3){
                #Unsafe
                $Safe=$false
            }
            If ($null -eq $Direction) {
                #The second level, so we decide the direction here
                #Note that if the levels are the same we don't really care- this report is already unsafe
                if ($level -ge $LastLevel){
                    $direction="Increasing"
                }else{
                    $direction="Decreasing"
                }
            } else {
                #CHeck the direction against the previous
                if (($level -gt $LastLevel -and $direction -ne "Increasing") -or
                    ($level -lt $LastLevel -and $direction -ne "Decreasing")){
                    $safe=$false
                }
            }
        }
        $LastLevel=$Level
    }
    #If the record is safe increment the counter
    If ($safe){$SafeReports++}
    #Debug Line to check result
    #"$Report $safe"
}


"$SafeReports Reports are Safe"
