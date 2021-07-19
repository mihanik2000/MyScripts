@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: YES (!!!)
REM
REM ��ਯ� ��⠭���� �⠭���⭮�� ����� �ணࠬ� � ����� ९������
REM
REM ****************************************

REM ��⠭�������� ���祭�� �������� ��६�����

REM ����砥� ��� �����, � ���ன �ᯮ����� �ਯ�
set ScriptPath=%~dp0

REM ����� ��� �६������ �࠭���� ��⠭������ ��� ᪠砭��� 䠩���
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
    IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
    ECHO .
    ECHO You need administrator rights to run!!!
    ECHO .
    GOTO END
)

REM ����祭�� ०��� �����ய�⠭�� "��᮪�� �ந�����⥫쭮���"
CALL %ScriptPath%\Powercfg\EnableHighPerformance.bat

REM �⪫�砥� ��騩 ०��
CALL %ScriptPath%\Powercfg\DisableHibernation

REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
CALL %ScriptPath%\UserManagement\SettingUpUserAccounts.bat

REM ��������㥬 ���������� �몫�祭�� � �������
CALL %ScriptPath%\WindowsScheduler\EnableDailyShutdown.bat

REM �믮��塞 ���������� ����ன�� ����⥢��� ��࠭�
CALL %ScriptPath%\WindowsFirewall\InitialFirewallSetup.bat

REM ������塞 �⨫��� certutil.exe � �᪫�祭�� ����⥢��� ��࠭� Windows
CALL %ScriptPath%\WindowsFirewall\AddCertutilToWindowsFirewallExceptions.bat

REM ����ந� ����������� ����������� �� RDP
CALL %ScriptPath%\WindowsServices\EnableRDPService.bat

REM ��⠭���� Curl
CALL %ScriptPath%\ProgramManagement\Curl-Install.bat

REM ��⠭���� Wget
CALL %ScriptPath%\ProgramManagement\Wget-Install.bat

rem ���室�� �� ��⥬�� ���
%SystemDrive%

rem ������ ����� ��� �࠭���� ����ਡ�⨢�� � ���室�� � ���
mkdir "%MyFolder%"
cd "%MyFolder%"


    ECHO .
    ECHO ���!
    ECHO .

:END

timeout 5  >> nul

REM shutdown -r -f -t 00

EXIT /B
