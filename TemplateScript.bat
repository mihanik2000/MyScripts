@echo off
chcp 65001
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        �ॡ���� ����稥 �ࠢ �����������: ��
REM ��⨢���᭠� �ணࠬ�� ������ ���� �⪫�祭�: ����⥫쭮, �� �� ��易⥫쭮
REM                                    ����砭��: ���
REM
REM ���ᠭ��
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

REM �஢��塞 ����稥 CURL

If exist "%SystemDrive%\Program Files\Curl" (
	ECHO CURL ������
 ) else (
	mkdir "%SystemDrive%\Program Files\Curl"

	If exist "%SystemDrive%\Program Files (x86)" (
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x32/curl-ca-bundle.crt -outfile \"%SystemDrive%\Program Files\Curl\curl-ca-bundle.crt\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x32/curl.exe -outfile \"%SystemDrive%\Program Files\Curl\curl.exe\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x32/libcurl.def.txt -outfile \"%SystemDrive%\Program Files\Curl\libcurl.def\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x32/libcurl.dll -outfile \"%SystemDrive%\Program Files\Curl\libcurl.dll\""
	 ) else (
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x64/curl-ca-bundle.crt -outfile \"%SystemDrive%\Program Files\Curl\curl-ca-bundle.crt\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x64/curl.exe -outfile \"%SystemDrive%\Program Files\Curl\curl.exe\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x64/libcurl-x64.def.txt -outfile \"%SystemDrive%\Program Files\Curl\libcurl-x64.def\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/curl/x64/libcurl-x64.dll -outfile \"%SystemDrive%\Program Files\Curl\libcurl-x64.dll\""
	)
)

REM �஢��塞 ����稥 WGET

If exist "%SystemDrive%\Program Files\Wget" (
	ECHO WGET ������
 ) else (
	mkdir "%SystemDrive%\Program Files\Wget"

	If exist "%SystemDrive%\Program Files (x86)" (
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/wget/x32/wget.exe -outfile \"%SystemDrive%\Program Files\Wget\wget.exe\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/wget/x32/wget.exe.debug.txt -outfile \"%SystemDrive%\Program Files\Wget\wget.exe.debug\""
	 ) else (
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/wget/x64/wget.exe -outfile \"%SystemDrive%\Program Files\Wget\wget.exe\""
		powershell -command "Invoke-WebRequest http://choco.mihanik.net/distr/wget/x64/wget.exe.debug.txt -outfile \"%SystemDrive%\Program Files\Wget\wget.exe.debug\""
	)
)

set token="6634623113:AAHoRP_N1dkmeHmqraFO2yxOQtYaHUaDjRM"
set chat_id="289889409"
set MESSAGE=test
"C:\Program Files\curl\curl.exe" --insecure --data chat_id=%chat_id% --data-urlencode "text='%MESSAGE%'"  "https://api.telegram.org/bot%token%/sendMessage"




:ENDSUB

timeout 3 >> nul

EXIT /B
