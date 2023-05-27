# VCenter information
$server = ""
$user = ""
$password = ''

# VM Host
$vmhost = ''

# New VM information
$vmname = ""
$cpucores = 1
$memorygb = 2
$diskspacegb = 50

# Connect to VMware server
Connect-VIServer -Force -Server $server -User $user -Password $password

# Create new VM
Get-VMHost | Where-Object {$_.Name -cmatch $vmhost} | New-VM -Name $vmname -NumCpu $cpucores -MemoryGB $memorygb -DiskGB $diskspacegb -NetworkName "Installation" -GuestId debian11Guest | Start-VM

# Wait for installation
# Start-Sleep -Duration (New-TimeSpan -Minutes 7)

# Set network to IT
Get-VM -Name $vmname | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName 'VM Network' -Confirm:$false

# Reboot
Get-VM -Name $vmname | Invoke-VMScript -ScriptType Bash -ScriptText "reboot" -GuestUser 'root' -GuestPassword 'changeMe!123'
Start-Sleep -Seconds 45

# Install Ansible
# Get-VM -Name $vmname | Invoke-VMScript -ScriptType Bash -ScriptText "apt-get update && apt-get install -y python3 python3-pip && pip install ansible" -GuestUser 'root' -GuestPassword 'changeMe!123'

# Get IP Address
$guestinfo = Get-VM -Name $vmname | Select-Object -ExpandProperty Guest
$vmipaddress = $guestinfo.IPAddress[0]

Write-Host "Guest IP Address: $($vmipaddress)"
