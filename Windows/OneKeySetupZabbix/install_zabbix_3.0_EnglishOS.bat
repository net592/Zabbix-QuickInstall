setlocal enabledelayedexpansion
@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit


echo PROCESSOR_ARCHITECTURE var:
echo %PROCESSOR_ARCHITECTURE% | find /i "x86" > nul
if %errorlevel%==0 (
    set netpath=\\10.22.1.102\e$\opstools\zabbixtool\zabbix30\win32\*
) else (
    set netpath=\\10.22.1.102\e$\opstools\zabbixtool\zabbix30\win64\*
)

set localpath="C:\opstools\zabbix30"

mkdir %localpath%
xcopy /ZYE %netpath% %localpath%\



:: Modely IP
set zabbix_server=10.22.1.172
set host_meta=%computername%.%userdomain%.COM
echo Zabbix_Server_IP %zabbix_server%
echo Local_AD_NAME %host_meta%
set /p host_name=Input_Zabbix_Auto_Name:(TJ-WIN-WEB-GROUP-1V100):
:: cp file server ip
set conf_file=%localpath%\conf\zabbix_agentd.win.conf
set conf_file_bak=%localpath%\conf\zabbix_agentd.win.conf.bak
del %conf_file%
for /f "delims=" %%a in ('type "%conf_file_bak%"') do (
  set str=%%a
  set "str=!str:127.0.0.1=%zabbix_server%!"
  set "str=!str:HOSTMETATEMP=%host_meta%!"
  set "str=!str:Windows host=%host_name%!"
  echo !str!>>"%conf_file%"
)



%localpath%\zabbix_agentd.exe --stop
%localpath%\zabbix_agentd.exe --config %localpath%\conf\zabbix_agentd.win.conf --uninstall

%localpath%\zabbix_agentd.exe --config %localpath%\conf\zabbix_agentd.win.conf --install
%localpath%\zabbix_agentd.exe --start

endlocal
echo "Setup Zabbinx....."
#setting powershell 
#powershell -noprofile Set-ExecutionPolicy RemoteSigned
for /f "skip=3 tokens=4" %%i in ('sc query "Zabbix Agent"') do set "zt=%%i" &goto :next
:next
if /i "%zt%"=="RUNNING" (
     echo install Zabbix Success
) else (
    echo Uninstall Zabbix Success Or Zabbix Agent Service no Stop
)
echo ------------------------------------------------------------------------
echo.
echo End
pause>nul
