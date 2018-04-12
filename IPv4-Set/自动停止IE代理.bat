@echo off
title 删除本机代理服务器设置

echo 正在写入注册值...
echo ==============================

REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyEnable" /t  REG_DWORD /d "0" /f 
::REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyServer" /t  REG_SZ /d "" /f 
::REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyOverride" /t  REG_SZ /d "10.*;127.*;172.*;192.*;<local>"  /f 
echo.
echo ==============================
echo 完成! 重启IE后生效
@pause