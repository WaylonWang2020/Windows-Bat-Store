@echo off
rem ����ѭ�����ʱ��ͼ��ķ���
set secs=1800
set srvname="Apache2.4"

echo.
echo ========================================
echo ==         ��ѯ����������״̬��     ==
echo ==     ÿ���%secs%���ֽ���һ�β�ѯ��   ==
echo ==       �緢����ֹͣ��������������   ==
echo ========================================
echo.
echo �˽ű����ķ����ǣ�%srvname%
echo.

if %srvname%. == . goto end

:chkit
set svrst=0
for /F "tokens=1* delims= " %%a in ('net start') do if /I "%%a %%b" == %srvname% set svrst=1
if %svrst% == 0 net start %srvname%
set svrst=
rem ���������������ʱ��������ܻᵼ��cpu�����������ء�
ping -n %secs% 127.0.0.1 > nul
goto chkit

:end