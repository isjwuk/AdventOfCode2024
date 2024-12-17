<#
.SYNOPSIS
    Day 1 of Advent of Code - Part 1
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    https://adventofcode.com/2024/day/1
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

#Read in the data
$InputData=(Get-Content .\day1.txt).Replace("   ",",")| ConvertFrom-Csv  -Header ("LeftList","RightList") 

#Extract sorted Left List and Right List
$LeftList=$InputData.LeftList | Sort-Object
$RightList=$InputData.RightList | Sort-Object

#Reset our running total
$Total=0
#Loop through the lists
for ($i=0;$i -lt $LeftList.length;$i++){
    #Get the difference between the two
    #Use Abs because Left List might be bigger than right
    $Total+= [Math]::Abs($RightList[$i]- $LeftList[$i])
}
#Output the final total
$Total