@echo off
title ɾ�������������������

echo ����д��ע��ֵ...
echo ==============================
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings\Connections" /v "DefaultConnectionSettings" /t  REG_BINARY /d "3C000000AA0100000B0000000F000000" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyEnable" /t  REG_DWORD /d "0" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyServer" /t  REG_SZ /d "" /f 
REG ADD "HKLM\System\CurrentControlSet\Hardware Profiles\0001\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyEnable" /t  REG_DWORD /d "1" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings\Connections" /v "SavedLegacySettings" /t  REG_BINARY /d "3C000000AE0100000B0000000F000000" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyOverride" /t  REG_SZ /d "<local>" /f 
echo.
echo ==============================
echo ���! ����IE����Ч
:end
exit