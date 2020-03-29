## Creator: Eduard Catalin Dragu - https://github.com/Dreggh
## Reason: Just a quick powershell that can be used with Task scheduler in order to archive my VMs on an external HDD.
## OS: Has been tested and currently running everyday on a Windows 10 machine.

## Creating the variables about the source and destination
$Date = Get-Date -Format dd-MM-yy
$SourceFolder = "L:\VMs\"
$DestinationFolder = "D:\VMs - Backups"
$DestinationFolderWithDate = "D:\VMs - Backups\" + $Date

# Checks if the destination directory exists, otherwise it will create it.

If(!(Test-Path $DestinationFolderWithDate))
{
    New-Item -ItemType Directory -Force -Path $DestinationFolderWithDate
}


# The copy comand by itself, it takes everything from the source to the destination recursively

Copy-Item -Path $SourceFolder -Destination $DestinationFolderWithDate -Recurse -Force

# Since I've a 1TB external HD I don't want to keep too much stuff, also because basically the script will create a new folder everyday. So the "retention" is 7 days.

$Days = "-0"
$DateWhenDelete = (Get-Date).AddDays($Days)

Get-ChildItem $DestinationFolder | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $DateWhenDelete} | Remove-Item -Recurse -Force
