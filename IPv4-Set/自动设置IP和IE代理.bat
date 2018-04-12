@echo off  
  
::echo set ip...  
::netsh interface ip set address name="本地连接" source=static addr=xxx.xxx.xxx.xxx mask=xxx.xxx.xxx.xxx  
  
::echo set gateway....  
::netsh interface ip set address name="本地连接" source=static gateway=xxx.xxx.xxx.xxx gwmetric=1  
  
echo set IE proxy: xxx.xxx.xxx.xxx:8080  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "xxx.xxx.xxx.xxx:8080" /f  
::跳过本地地址的代理服务器  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "<local>" /f  
  
echo flushdns...  
ipconfig /flushdns
@pause