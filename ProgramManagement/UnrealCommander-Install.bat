@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM		   Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM						   Dependencies: You must first run Curl-Install.bat and Wget-Install.bat
REM
REM Install Unreal Commander
REM
REM ****************************************

REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run!
	ECHO .
	GOTO ENDSUB
)

REM ����� ���祭�� ��६�����
set MyFolder=%SystemRoot%\TMP\Mihanikus

set URLuncomsetup="https://x-diesel.com/download/uncomsetup.exe?32"
set URLuncomsetup-x64="https://x-diesel.com/download/uncomsetup.exe?64"

REM ���室�� �� ��⥬�� ���
%SystemDrive%

REM ������ ����� ��� �࠭���� ����ਡ�⨢�� � ���室�� � ���
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Unreal Commander...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\uncomsetup.exe" %URLuncomsetup-x64%
     ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\uncomsetup.exe" %URLuncomsetup%
        Start /wait npp.exe /S
    )

	start uncomsetup.exe /VERYSILENT /NORESTART /SP- woex

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
