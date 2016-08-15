@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

echo "setting powershell"
#setting powershell 
powershell -noprofile Set-ExecutionPolicy RemoteSigned