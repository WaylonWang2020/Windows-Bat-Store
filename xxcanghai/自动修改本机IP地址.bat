@echo off
setlocal enabledelayedexpansion
title �޸ı���IP��ַ  by:СС�׺�20130409
:init
cls&echo �����������������������������Զ��޸ı���IP��ַ����������������������������
rem ϵͳ�汾��ֵ��ΪWindows7����WindowsXP������auto����ʾ�Զ���ȡ��
set SYSVER=auto
rem Ҫ���ĵ��������ƣ�auto��ʾ�Զ���ȡ��һ�顰��̫����������
set ETH=auto
rem IP��Դ��ֵ��Ϊ����static��dhcp��ques��ʾѯ�ʣ���ʹ������д
rem ��̬IP����дstatic���������Զ���ȡIP����дdhcp
set IPSOURCE=ques
rem Ҫ�ĳɵ�IP��ַ��quesͬ��
set IPADDR=ques
rem Ҫ�ĳɵ��������룬quesͬ��
set MASK=ques
rem Ҫʹ�õ�Ĭ�����أ�quesͬ��
set GATEWAY=ques
rem DNSģʽ��ֵ��Ϊ����static��dhcp
rem ��̬DNS����дstatic���������Զ���ȡDNS����дdhcp
set DNSSOURCE=ques
rem Ҫʹ�õ���ѡDNS��quesͬ��
set DNS1=ques
rem Ҫʹ�õı���DNS��quesͬ��
set DNS2=ques
set LOG=%TEMP%\changeIP_log.txt
echo ��������:%date% %time%>%LOG%


:start
rem ===============ʹ������д����ֵ=======================
rem �Զ���ȡϵͳ�汾�����Ϊ Windows7 ���� WindowsXP(ֻ������������ϵͳ)
if "%SYSVER%"=="auto" (
    set /p=�����Զ���ȡϵͳ�汾...<nul
    for /f "skip=1 tokens=2-3 delims= " %%i in ('wmic os get caption') do set SYSVER=%%i%%j
    if /i "!SYSVER!"=="Windows7" (
        echo �ɹ���[Win7]
    ) else (
        if /i "!SYSVER!"=="WindowsXP" (
            echo �ɹ���[WinXP]
        ) else (
            echo [!SYSVER!]
            echo ��ע�⡿��Win7��XPϵͳ����֤��ִ�гɹ���&pause>nul
        )
    )
)

rem �Զ���ȡ��������
if "%ETH%"=="auto" (
    echo �����Զ���ȡ������������Ϣ...
    set index=0
    set select=1
    for /f "skip=3 tokens=4* delims= " %%i in ('netsh interface ipv4 show interfaces^|find /i /v "Loopback"') do (
        set /a index=!index!+1
        set ethname=%%j
        echo [!index!]!ethname!
    )
    if !index!==1 (
        set ETH=!ethname!
    ) else ( if !index! GTR 1 (
        :select
        set /p=��ѡ��Ҫ���õ��������:<nul
        set select=0&set /p select=
        if /i !select! LSS 1 goto select
        if /i !select! GTR !index! goto select
        set index=0
        for /f "skip=3 tokens=4* delims= " %%i in ('netsh interface ipv4 show interfaces^|find /i /v "Loopback"') do (
            set /a index=!index!+1
            if !index!==!select! (
                set ETH=%%j
            )
        )
    ))

    if "!ETH!"=="auto" (
        echo �Զ���ȡ��������ʧ�ܣ����Ҽ��༭���������ֶ���д�������ƣ�&pause>nul&exit
    ) else (
        rem set/p=[!ETH!]<nul
        echo �ɹ���
    )
)

:quesIP
if "%IPSOURCE%"=="ques" (
    echo ������д��IP��ַ��Դ��^(ֵ��Ϊ����static��dhcp��ֱ�ӻس�Ϊstatic^)
    set /p IPSOURCE=
    if "!IPSOURCE!"=="ques" set IPSOURCE=static
    if /i "!IPSOURCE!" NEQ "static" (if /i "!IPSOURCE!" NEQ "dhcp" (
        set IPSOURCE=static
        echo IP��Դ��д���󣬽����Ϊstaticģʽ
        pause>nul
    ))
)
if /i "%IPSOURCE%"=="dhcp" goto quesDNS

if "%IPADDR%"=="ques" (
    echo ������д��IP��ַ��^(ֱ�ӻس�Ϊ192.168.1.100^)
    set /p IPADDR=
    if "!IPADDR!"=="ques" set IPADDR=192.168.1.100
)

if "%MASK%"=="ques" (
    echo ������д���������롿^(ֱ�ӻس�Ϊ255.255.255.0^)
    set /p MASK=
    if "!MASK!"=="ques" set MASK=255.255.255.0
)

if "%GATEWAY%"=="ques" (
    echo ������д��Ĭ�����ء�^(ֱ�ӻس�Ϊ192.168.1.1^)
    set /p GATEWAY=
    if "!GATEWAY!"=="ques" set GATEWAY=192.168.1.1
)

:quesDNS
if "%DNSSOURCE%"=="ques" (
    echo ������д��DNS��Դ��^(ֵ��Ϊ����static��dhcp��ֱ�ӻس�Ϊstatic^)
    set /p DNSSOURCE=
    if "!DNSSOURCE!"=="ques" set DNSSOURCE=static
    if /i "!DNSSOURCE!" NEQ "static" (if /i "!DNSSOURCE!" NEQ "dhcp" (
        set DNSSOURCE=static
        echo DNS��Դ��д���󣬽����Ϊstaticģʽ
        pause>nul
    ))
)
if /i "%DNSSOURCE%"=="dhcp" goto checkInfo

if "%DNS1%"=="ques" (
    echo ������д����ѡDNS��ַ��^(ֱ�ӻس�Ϊ8.8.8.8^)
    set /p DNS1=
    if "!DNS1!"=="ques" set DNS1=8.8.8.8
)

if "%DNS2%"=="ques" (
    echo ������д������DNS��ַ��^(ֱ�ӻس�Ϊ8.8.4.4^)
    set /p DNS2=
    if "!DNS2!"=="ques" set DNS2=8.8.4.4
)


:checkInfo
cls
echo ����Ӧ���������ã�
call :showInfo
echo ��ȷ����Ϣ�Ƿ���ȷ������Y����������N�˳�������Q��ʾ����������Ϣ
set choose=nul&set /p choose=
if /i "%choose%"=="nul" goto checkInfo
if /i "%choose%"=="N" exit
if /i "%choose%"=="Q" call :getInfo & pause & goto checkInfo
if /i "%choose%" NEQ "Y" goto checkInfo
echo ��ע�����رշ���ǽ���������е����İ�ȫ�����ʾ�������޷��ɹ�ִ�У�

:changeIP
rem ͨ��dhcpɾ��ԭ��IP����
echo ������"%ETH%"��IPԴΪDHCP����ɾ��ԭ��IP��ַ >>%LOG%
netsh -c interface ip set address name="%ETH%" source=dhcp >>%LOG%
if /i "%IPSOURCE%"=="static" (
    echo ������IPΪ"%IPADDR%"������Ϊ"%MASK%"������Ϊ"%GATEWAY%" >>%LOG%
    netsh -c interface ip set address name="%ETH%" source=static address="%IPADDR%" mask="%MASK%" gateway="%GATEWAY%" gwmetric=1 >>%LOG%
)
rem ɾ��ԭ��DNS����
echo ��ɾ��ԭ��DNS���� >>%LOG%
netsh -c interface ip delete dns "%ETH%" all >>%LOG%
if /i "%DNSSOURCE%"=="static" (
    echo ��������ѡDNSΪ%DNS1% >>%LOG%
    netsh -c interface ip add dns name="%ETH%" addr="%DNS1%" index=1 >>%LOG%
    echo �����ñ���DNSΪ%DNS2% >>%LOG%
    netsh -c interface ip add dns name="%ETH%" addr="%DNS2%" index=2 >>%LOG%
    rem ���˴��ɼ������Ӷ��DNS��������ַ
) else (if /i "%DNSSOURCE%"=="dhcp" (
    echo ������DNSΪDHCPģʽ >>%LOG%
    netsh -c interface ip set dns name="%ETH%" dhcp >>%LOG%
))

:end
cls
rem echo ��Ҫ�趨����Ϣ��
rem call :showInfo
echo ����ǰ������Ϣ��
call :getInfo
echo ======================================
echo �������һ����˵���޸ĳɹ���
echo �����һ������鿴��־�ļ���
echo ����L�鿴��־�ļ�������E�˳�����
set choose=nul&set /p choose=
if /i "%choose%"=="L" start %LOG%&goto end
if /i "%choose%"=="E" exit
if /i "%choose%"=="nul" goto end


echo ����ִ�н�������������˳�...
pause>nul
exit


:showInfo
echo ������ϵͳ����%SYSVER%
echo ���������ơ���%ETH%
echo ��IP��Դ  ����%IPSOURCE%
if "%IPSOURCE%"=="static" (
    echo ��IP��ַ  ����%IPADDR%
    echo ���������롿��%MASK%
    echo ��Ĭ�����ء���%GATEWAY%
)
echo ��DNS��Դ ����%DNSSOURCE%
if "%DNSSOURCE%"=="static" (
    echo ����ѡDNS ����%DNS1%
    echo ������DNS ����%DNS2%
)
rem goto :eof���ڷ���return
goto :eof


:getInfo
netsh -c interface ip show address name="%ETH%"
netsh -c interface ip show dns name="%ETH%"
goto :eof

:windows7