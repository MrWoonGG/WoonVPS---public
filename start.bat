@echo off
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 By MrWoon" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
net user administrator MrWoonTT12 /add >nul
net localgroup administrators administrator /add >nul
net user administrator /active:yes >nul
net user installer /delete
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant administrator:F >nul
ICACLS C:\Windows\installer /grant administrator:F >nul
echo  Successfully Installed !, If the RDP is Dead, Please Rebuild Again! 
@echo off
setlocal

for /f "tokens=*" %%i in ('tasklist ^| find /i "ngrok.exe"') do (
    set "output=%%i"
)

REM Проверяем, была ли найдена строка с "ngrok.exe"
if defined output (
    for /f "tokens=*" %%j in ('curl -s localhost:4040/api/tunnels ^| jq -r .tunnels[0].public_url') do (
        set "ipAddress=%%j"
    )
) else (
    set "ipAddress=Unable to get NGROK tunnel"
)

echo IP: 
echo %ipAddress%
echo Username: administrator
echo Password: MrWoonTT12
echo .
echo  RDP By MrWoon
echo   Connect to Your RDP !
ping -n 10 127.0.0.1 >nul

endlocal
