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
REM Install curl
REM
REM ****************************************

rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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

echo .
echo ��⠭�������� CURL
echo .

rem ���室�� �� ��⥬�� ���
%SystemDrive%

REM ������ ����� ��� CURL
mkdir  "%ProgramFiles%\Curl\"

REM ���室�� � ᮧ������ �����
cd "%ProgramFiles%\Curl\"

REM ���稢��� CURL
If exist "%SystemDrive%\Program Files (x86)" (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.dll" "%ProgramFiles%\curl\libcurl-x64.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl.exe" "%ProgramFiles%\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.def" "%ProgramFiles%\curl\libcurl-x64.def"

 ) else (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.dll" "%ProgramFiles%\curl\libcurl.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl.exe" "%ProgramFiles%\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.def" "%ProgramFiles%\curl\libcurl.def"
)

rem ��⠭���� ᪠砭�� ���䨪�� ��� ��� ���짮��⥫��
rem certutil -f -addstore "My" "%ProgramFiles%\curl\curl-ca-bundle.crt"

rem ������� ���� � curl � path
setx PATH "%ProgramFiles%\curl\;%Path%"
PATH=%ProgramFiles%\curl\;%Path%

rem ������塞 �⨫��� curl.exe � �᪫�祭�� �࠭����� Windows
netsh advfirewall firewall del rule name="curl"
netsh firewall add allowedprogram "%ProgramFiles%\Curl\curl.exe" curl
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="%ProgramFiles%\Curl\curl.exe"

echo .
echo ��⠭���� CURL �����祭�
echo .

:ENDSUB

timeout 3 >> nul

EXIT /B
