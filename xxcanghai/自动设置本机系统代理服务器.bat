@echo off
title �Զ�����IE���������IP  By:СС�׺�  2010.9.15
::color 80&mode con cols=60 lines=20

::�����н�set host=xxx����ΪҪping����������
set host=BJ-CLT-003
::�������޸�Ŀ��������˿ں�
set port=8888
for /f "tokens=2 delims=[]" %%i in ('ping %host% /n 1 -4 ^| findstr "Ping"') do echo �������ƣ�%host%   IP��ַ��%%i:%port%&set ip=%%i
set ip>nul 2>nul
if %errorlevel%==1 echo ����%host%û���ҵ�,�������������Ƿ���ȷ!&goto end
::�����Ҫֱ��ָ��IP��ַ���ɾ������for�����к�if�����У�ֱ���޸�set ip=x.x.x.x����


echo ����д��ע��ֵ...
echo ==============================
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings\Connections" /v "DefaultConnectionSettings" /t  REG_BINARY /d "3C000000AA0100000B0000000F000000" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyEnable" /t  REG_DWORD /d "1" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyServer" /t  REG_SZ /d "%ip%:%port%" /f 
REG ADD "HKLM\System\CurrentControlSet\Hardware Profiles\0001\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyEnable" /t  REG_DWORD /d "1" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings\Connections" /v "SavedLegacySettings" /t  REG_BINARY /d "3C000000AE0100000B0000000F000000" /f 
REG ADD "HKCU\SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\Internet Settings" /v "ProxyOverride" /t  REG_SZ /d "<local>" /f 
echo.
echo ==============================
echo ���! ����IE����Ч
:end
ping 127.1 /n 3 >nul&exit