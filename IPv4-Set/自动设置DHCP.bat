@echo off  
  
::echo set dhcp...  
netsh interface ip set address name="本地连接" source = dhcp

::echo set dns....
netsh interface ip set dns "本地连接" source = dhcp
@pause