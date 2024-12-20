<#
.SYNOPSIS
    Day 2 of Advent of Code - Part 2
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


function CheckReport {
    param (
        [string]$Report
    )
    Write-Host $Report
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
    Return $safe
}



#Read in the data
$InputData=(Get-Content .\day2.txt)

#A running total of Safe Reports
$SafeReports=0

#Loop Through Lines (Reports)
Foreach ($Report in $InputData){ 
           if (CheckReport -Report $Report){
            #Safe without removing any level
            $SafeReports++
        } else {
            #try removing one level from the report at the time until we get a result
            $lastStart=0
            $safe=$false
            #Check the Report with the first Level missing
            if  (CheckReport -report $report.substring($report.indexof(" ")).trim()){$safe=$true}
            while ($laststart -lt $report.LastIndexOf(" ")-1 -and !$safe){
                $NewReport=$report.Substring(0,$report.IndexOf(" ",$laststart))+$report.Substring($report.IndexOf(" ",$laststart+2))
                
                if (CheckReport -Report $NewReport){
                    $safe=$true
                   # $NewReport
                }
                $laststart=$report.IndexOf(" ",$laststart+1)

            }
            #And Finally, check the Report with the last Level missing
            if (!$safe -and (CheckReport -report $report.substring(0,$report.lastindexof(" ")).trim())){$safe=$true}
            if ($safe){$SafeReports++}
        }
    
    

}


"$SafeReports Reports are Safe"

