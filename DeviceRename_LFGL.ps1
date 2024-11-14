$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

 Start-Transcript -Path "$env:windir\temp\DeviceRename_Scheduledtask-Systrack.log"
Suspend-BitLocker -MountPoint "C" -RebootCount 1 -Verbose
##########################################################
###############-------------Step 1---#####################
##############--Enter your username and Password---#######
#############---Save it on a shared network drive --######
##########################################################
##<<-------------->>Variables<<--------------------->>####
##
$KeyLocation = "\\pw1appsccm01\sources$\temp\temp5.key"
# $KeyLocation = "\\NetworkLocation\c$\temp\EncryptedKey.key"
$username = "ibddomain\lrazo"
#$LocationPrefix = "ATLL"
##
##
##########################################################
#$credential = Get-Credential
#$Key = [byte]1..16
#$credential.Password | ConvertFrom-SecureString -Key $Key | Set-Content $KeyLocation
##########################################################
##
##
##########################################################
##<<---------<><><>DO NOT MODIFY BELOW<><><>-----------###
##
$Key = [byte]1..16
$encrypted = Get-Content $KeyLocation | ConvertTo-SecureString -Key $Key
$credential = New-Object System.Management.Automation.PsCredential($username, $encrypted)
$Serial = (get-ciminstance win32_bios).SerialNumber

$ComputerName = $env:COMPUTERNAME.substring(0, 4)
    switch($ComputerName)
{ 
    "ATLL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "PHXL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "OAKL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "STPL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "SDLL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "LAVL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "JSCL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "PADL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "HOLL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "NORL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
    "LFGL"  {$LocationPrefix = "LFGL" ; Write-Host -Object "LFGL" }
}#

Rename-Computer -ComputerName $env:COMPUTERNAME -NewName "$LocationPrefix-$serial" -LocalCredential $Credential -DomainCredential $Credential  -Force -PassThru  -Verbose
Write-Host "New computer name is " $env:COMPUTERNAME
shutdown /r /f /t 14400 /c "Please Reboot your Computer, System needs to reboot, please save your work."

Stop-Transcript



