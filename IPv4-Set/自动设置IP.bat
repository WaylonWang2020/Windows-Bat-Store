@echo off  
  
::echo set ip...  
netsh interface ip set address name="本地连接" source=static addr=xxx.xxx.xxx.xxx mask=xxx.xxx.xxx.xxx
  
::echo set gateway....  
netsh interface ip set address name="本地连接" source=static gateway=xxx.xxx.xxx.xxx gwmetric=1

::echo set dns....
netsh interface ip set dns "本地连接" static xxx.xxx.xxx.xxx primary
netsh interface ip set dns "本地连接" static xxx.xxx.xxx.xxx
@pause