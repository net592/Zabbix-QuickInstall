@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

echo "Uninstall Zabbix Agent"

net stop "Zabbix Agent"

C:\opstools\zabbix\zabbix_agentd.exe -c C:\opstools\zabbix\zabbix_agentd.win.conf -d

echo "setting powershell"
#setting powershell 
#powershell -noprofile Set-ExecutionPolicy RemoteSigned
for /f "skip=3 tokens=4" %%i in ('sc query "Zabbix Agent"') do set "zt=%%i" &goto :next
:next
if /i "%zt%"=="RUNNING" (
    echo 已经发现Zabbix该服务在运行。
) else (
    echo 卸载成功,Zabbix服务现在已停止状态。
)
echo ------------------------------------------------------------------------
echo.
echo 已经结束。
echo. & pause
