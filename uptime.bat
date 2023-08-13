@echo off
setlocal

for /f "delims=: tokens=2" %%A in ('tasklist ^| find /i "ngrok.exe" ^>Nul ^&^& curl -s localhost:4040/api/tunnels ^| jq -r .tunnels[0].public_url') do (
    set "ngrok_data=%%A"
)
for /f "delims=://" %%B in ("%ngrok_data%") do (
    set "ngrok_host=%%B"
    set "ngrok_port=%%C"
)

set "API_KEY=u1851271-4409b294fe8f0c384148ff5e"

set "CREATE_MONITOR_URL=https://api.uptimerobot.com/v2/newMonitor"

set "payload=api_key=%API_KEY%&format=json&type=4&sub_type=99&url=%ngrok_host%&port=%ngrok_port%&friendly_name=WoonVDS-Motitor-%random%"

curl -s -d "%payload%" -H "cache-control: no-cache" -H "content-type: application/x-www-form-urlencoded" %CREATE_MONITOR_URL%

echo %ngrok_host%:%ngrok_port%

endlocal
