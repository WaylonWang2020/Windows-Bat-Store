::NetstatFilter�������Ӳ鿴�� @СС�׺� xxcanghai.cnblogs.com By:2015��6��29��
@echo off
:start
title NetstatFilter By:xxcanghai
SETLOCAL ENABLEEXTENSIONS&SETLOCAL ENABLEDELAYEDEXPANSION
cls

::######config######
set PCENAME=
set PID=
set PORT=

::inner config
set ERRORCODE=0

:menu
cls&echo ----------NetstatFilter----------
echo [1]��ѯָ��������ʹ�õĶ˿ں�
echo [2]�鿴ָ���˿ڱ��ĸ�����ʹ��
echo [3]������Ϣ
echo.
set /p=�������Ӧ����:<nul
set select=3&set /p select=
if /i "%select%"=="q" exit /b
if /i "%select%"=="exit" exit /b
if "%select%"=="1" goto :menuitem1
if "%select%"=="2" goto :menuitem2
if "%select%"=="3" goto :help
cls&goto :menu

:menuitem1
set /p=������Ҫ��ѯ�Ľ�������:<nul
set PCENAME=&set /p PCENAME=
if /i "%PCENAME%"=="q" goto :menu
if "%PCENAME%"=="" goto :menuitem1
if "%PCENAME:.=%"=="%PCENAME%" set PCENAME=%PCENAME%.exe
call :getpid "%PCENAME%" PID
echo Process:%PCENAME%,PID:%PID%
call :getnetbypid "%PID%"
echo @1END&pause>nul&goto start


:menuitem2
set /p=������Ҫ��ѯ�Ķ˿ں�:<nul
set PORT=&set/p PORT=
if /i "%PORT%"=="q" goto :menu
if "%PORT%"=="" goto :menuitem2
call :getnetbyport "%PORT%"
echo @2END&pause>nul&goto start


:help
cls
echo ������������������������������NetstatFilter ����������������������������������
echo ��           netstat����ĸ������� @СС�׺� xxcanghai.cnblogs.com          ��
echo ��                                                                          ��
echo ��1.�ɲ�ѯĳ��������ʹ����Щ�˿ڣ�����ͬ�����̵Ķ��ʵ��������TCP��UDP�˿�  ��
echo ��2.�ɲ�ѯָ���˿����ڱ���Щ����ʹ�ã��Լ�����/Զ��IP�˿ں͵�ǰ����״̬     ��
echo ��                                =ע��=                                    ��
echo ����1.���޷�ʹ�û��ѯ�޷�Ӧ���ù���ԱȨ��ִ�б��������������������������©�
echo ������������������������������������������������������������������������������

echo ��������������˵�&pause>nul&goto start

::#####get pid by process#####
::[tasklist] example
::cmd.exe                      11132 Console                    1      3,000 K
::cmd.exe                       8204 Console                    1      2,728 K
::cmd.exe                      10060 Console                    1      2,996 K
:getpid
if not "%~1"=="" (
	set PID=
	for /f "tokens=2 delims= " %%i in ('tasklist /fi "imagename eq %~1" /nh /fo table^|find /i "%~1"') do (
		set PID=!PID!%%i,
	)
	if "!PID!"=="" (
		set ERRORCODE=101
		echo [ERROR]ProcessName "%~1" is not found
		pause>nul&goto start
	) else (
		set PID=!PID:~0,-1!
	)
	set %2=!PID!
	goto :eof
)


::#####get netstat by pid#####
::[netstat] example:
::  Proto  Local Address          Foreign Address        State           PID
::   TCP    0.0.0.0:80             0.0.0.0:0              LISTENING       4
::   UDP    [::1]:50575            *:*                                    5108
:getnetbypid
if not "%~1"=="" (
	set PID=%~1
	for /f "tokens=1,* delims=," %%a in ("!PID!") do (
		set subpid=%%a
		set PID=%%b
		::get TCP
		echo [PID-!subpid!]:
		for /f "delims=" %%z in ('netstat -a -n -o^|find ":"') do (
			set tLine=%%z
			::netstat��IPv6����к���%���ţ�%������call�����лᷢ�������콫%�滻Ϊ$���ٴ���
			set tLine=!tLine:%%=$!
			call :getNetInfo "!tLine!" tProto tLocalAdd tForeignAdd tState tPID
			set tLine=!tLine:$=%%!
			::callʹ����ɺ�$�����滻��%����
			if "!tPID!"=="!subpid!" (
				echo !tLine!
			)
		)
	)
	if not "!PID!"=="" (call %0 "!PID!")
	goto :eof
)


::#####get netstat by port#####
:getnetbyport
if not "%~1"=="" (
	set PORT=%~1
	for /f "tokens=1,* delims=," %%a in ("!PORT!") do (
		set myport=%%a
		set PORT=%%b
		::PORT==8888
		for /f "delims=" %%z in ('netstat -a -n -o^|find /i ":!myport! "') do (
			set tLine=%%z			
			set tLine=!tLine:%%=$!
			call :getNetInfo "!tLine!" tProto tLocalAdd tForeignAdd tState tPID
			set tLine=!tLine:$=%%!			
			echo !tLine!
			for /f "tokens=1 delims= " %%j in ('tasklist /nh /fi "PID eq !tPID!"') do (
				echo [%%j]
			)
		)
	)
)
goto :eof


echo END.&pause>nul&goto start
exit

::#####FUNCTION#####
:getNetInfo
::��netstat -ano��ĳһ�зָ��ɲ�ͬ�ı���
::call :getNetInfo "<netstat output line>" tProto tLocalAdd tForeignAdd tState tPID
if not "%~1"=="" (
	for /f "tokens=1,2,3,4,5 delims= " %%i in ("%~1") do (
		set %2=%%i
		set %3=%%j
		set %4=%%k
		if "%%i"=="TCP" (
			set %5=%%l
			set %6=%%m
		) else (
			set %5=
			set %6=%%l
		)
	)
)
goto :eof

::#####FUNCTION#####
:split
::%0Ϊ������������:split��%1Ϊ��������ֵ,%~1Ϊɾ�������е�˫����"
::�ڴ������������аѹ���������/���ŷָ����ȡ�÷ָ��ĵ�һ����ֵ
::�ٰѷָ���ʣ�µ�ֵ�ظ��������������������ֱ��������Ϊ��Ϊֹ������
set subf=%~1
for /f "tokens=1,* delims=," %%j in ("%subf%") do (

	set subf=%%k
)
if not "!subf!"=="" (call %0 "!subf!")
goto :eof


::#####FUNCTION#####
:FUN1

goto :eof