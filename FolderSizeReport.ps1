# LocalDisk Directories Mapping Report

$base = $env:USERPROFILE
$desktop = "$base\Desktop"

$ask = read-host "Enter the drive letter to be scanned..."
$start = "$ask" + ":\"

$dirs = Get-ChildItem $start -Directory -Recurse -Force -ErrorAction Ignore
$dcount = $dirs.count; cls; Write-Host "$dcount Folders Found  

"

$i = 0
$report = @()
foreach ($dir in $dirs){
    $i++
    $count = $($dir.Count)
    $sum = $($dir.Sum)
    $property = $($dir.Property)
    $fullname = $($dir.FullName)
    $name = $($dir.Name)
    write-host "$i of $dcount Folders being analyzed...  "

    $colItems = (Get-ChildItem $dir.FullName | Measure-Object -property length -sum)
    $Size = "{0:N2}" -f ($colItems.sum / 1MB)


    $report += New-Object psobject -Property @{Folder=$name;SizeMB=$Size;Path=$fullname}
}
cls
$report | select Path,SizeMB | Export-CSV -NoTypeInformation -Path "$Desktop\$ask Drive Folder Size Mapping.csv"


