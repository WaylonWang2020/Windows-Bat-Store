@echo off  
  
::echo set dhcp...  
netsh interface ip set address name="��������" source = dhcp

::echo set dns....
netsh interface ip set dns "��������" source = dhcp
@pause