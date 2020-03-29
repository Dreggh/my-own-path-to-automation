## Creator: Eduard Catalin Dragu - https://github.com/Dreggh
## Reason: A simple script that automatically removes the Windows's 10 built-in-apps, also it removes all the folders that are showed on "This PC".
## OS: Windows 10, I've been using this almost everytime.
## Please keep in mind that this is based on MY personal choice which is different from yours!

## Remove packages that may still be usefull, take your choice and think if you really want to delete them.

# Get-AppxPackage *windowscalculator* | Remove-AppxPackage
# Get-AppxPackage *photos* | Remove-AppxPackage
# Get-AppxPackage *windowsstore* | Remove-AppxPackage

## Remove packages that are relly the built-in apps.


Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Get-AppxPackage *windowsalarms* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *windowscamera* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *skypeapp* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *zunemusic* | Remove-AppxPackage
Get-AppxPackage *windowsmaps* | Remove-AppxPackage
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Get-AppxPackage *zunevideo* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *onenote* | Remove-AppxPackage
Get-AppxPackage *people* | Remove-AppxPackage
Get-AppxPackage *windowsphone* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Get-AppxPackage *bingweather* | Remove-AppxPackage
Get-AppxPackage *xboxapp* | Remove-AppxPackage

## Change the registry's key value to "Hide" to Hide My Folder on This PC section.

Set-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag\' -Name 'ThisPCPolicy' -Value 'Hide'
Set-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag\' -Name 'ThisPCPolicy' -Value 'Hide'
Set-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag\' -Name 'ThisPCPolicy' -Value 'Hide'
Set-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag\' -Name 'ThisPCPolicy' -Value 'Hide'
Set-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag\' -Name 'ThisPCPolicy' -Value 'Hide'
Set-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag\' -Name 'ThisPCPolicy' -Value 'Hide'

## Remove the registry key that is used by 3D build

Remove-Item -path 'HKLM:\SOFTWARE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513*}'
