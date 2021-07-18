@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
REM
REM ��ਯ� ��⠭���� �⠭���⭮�� ����� �ணࠬ� � ����� ९������
REM
REM ****************************************

REM ****************************************
REM ��⠭�������� ���祭�� �������� ��६�����
REM ****************************************

REM �����, � ���ன �ᯮ����� �ਯ�
set ScriptPath=%~dp0

REM ****************************************************************************************
REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
REM ****************************************************************************************

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

REM ����祭�� ०��� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
CALL %ScriptPath%\Powercfg\EnableHighPerformance.bat

:CONTINUE
    ECHO .
    ECHO ���!
    ECHO .

:END

timeout 5  >> nul

REM shutdown -r -f -t 00

EXIT /B
