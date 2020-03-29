## Creator: Eduard Catalin Dragu - https://github.com/Dreggh
## Reason: Configuration of the OS-side of a Windows's Server system after the deployment from a template.
## OS: Tested for sure on some Windows Server 2019 that has been built just for this test.

## Checks Window's updates and installs it if requested - Putted at first since it will take some times

$Updates = Read-Host -Prompt 'Do you want to perform the Windows Updates or not? Y or N'
if ($Updates -eq 'Y') {
    wuauclt /detectnow /updatenow
} 
else { "Alright, do whatever you want. I'm out but I've already called Cabiola. NINONINONINO." }

## Enable of Remote Desktop Service and configuring the firewall to allow the group

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

## Enable ICMPv6 exception on firewall

netsh advfirewall firewall add rule name="ICMP Allow ping request" protocol=icmpv6:8,any dir=in action=allow

## Asks for the interface data as interface index, IP, subnet and default gateway

$InterfaceIndex = Read-Host -Prompt 'Execute Get-DnsClientServerAddress and insert here the interface index that you want to work with'
$IP = Read-Host -Prompt 'Insert the IP right here'
$Subnet = Read-Host -Prompt 'Insert the subnet here (as /)'
$DefaultGateway = Read-Host -Prompt 'Insert the default gateway here'
$DNS1 = Read-Host -Prompt 'Insert the primary DNS here'
$DNS2 = Read-Host -Prompt 'Insert the secondary DNS here'

## Uses the variable setted above in order to set the NIC



"The IP will be $IP"
"The subnet will be a /$Subnet subnet"
"The default Gateway will be $DefaultGateway"
"The primary DNS will be $DNS1 meanwhile the secondary will be $DNS2"

$NetworkChoice = Read-Host -Prompt 'Are these informations correct? Y or N'

if ($NetworkChoice -eq 'Y') {
New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress $IP -PrefixLength $Subnet -DefaultGateway $DefaultGateway 
Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses($DNS1,$DNS2) 
} else { "Your dumb. Restart everything, in progress something better" }

## Disable of the IPv6 on ALL the NICs

Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

## Expand the disk C to the maximum if requested

$WillingDisk = Read-Host -Prompt 'Do you want to expand the disk C to the maximum?'
if ($WillingDisk -eq 'Y') {
    $MaxSize = Get-PartitionSupportedSize -DriveLetter C
    Resize-Partition -DriveLetter C -Size $MaxSize.SizeMax -Confirm
    }

## Rename of the server and has an if that lets you choice if you want to use the domain or not, also joins to domain for you.

$Hostname = Read-Host -Prompt 'Insert the hostname here'
$DomainOrLocal = Read-Host -Promp 'Do you want to use [L]ocal or [D]omain credentials? The domain one will also do the AD-Join'

if ($DomainOrLocal -eq 'L') { 
    $LocalUser = Read-Host -Prompt 'Insert the username'
    Rename-Computer -NewName $Hostname -LocalCredential $LocalUser -Confirm -Restart 
}
elseif ($DomainOrLocal -eq 'D') {
   $Domain = Read-Host -Prompt 'Insert the domain'
   $User = Read-Host -Prompt 'Insert the username'
    
   Add-Computer -DomainName $Domain -Credential $User@$Domain -NewName $Hostname
   $RebootChoice = Read-Host -Prompt 'Do you want to reboot the server now? Y or N.'

   if ($RebootChoice -eq 'Y') {
   shutdown /r /t 3600 
   "Since the Windows's update may still be running the server will be automatically rebooted in 60 minutes. Take a pausa!"
   } else { 
           "Alright! Fuck off."
           }
}
