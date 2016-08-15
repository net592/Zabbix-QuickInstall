setlocal
@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit



set localpath="C:\opstools\zabbix30"


%localpath%\zabbix_agentd.exe --stop
%localpath%\zabbix_agentd.exe --config %localpath%\conf\zabbix_agentd.win.conf --uninstall
del %localpath%\conf\zabbix_agentd.win.conf
ENDLOCAL
for /f "skip=3 tokens=4" %%i in ('sc query "Zabbix Agent"') do set "zt=%%i" &goto :next
:next
if /i "%zt%"=="RUNNING" (
    echo 已经发现Zabbix该服务在运行。
) else (
    echo 卸载成功,Zabbix服务现在已停止状态。
)
del C:\opstools\zabbix30  /f/s/q/a
pause>nul