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

rem Проверяем наличие у пользователя админских прав...
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
echo Устанавливаем CURL
echo .

rem Переходим на системный диск
%SystemDrive%

REM Создаём папку для CURL
mkdir  "%ProgramFiles%\Curl\"

REM Переходим в созданную папку
cd "%ProgramFiles%\Curl\"

REM Скачиваем CURL
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

rem Установим скачанный сертификат для всех пользователей
rem certutil -f -addstore "My" "%ProgramFiles%\curl\curl-ca-bundle.crt"

rem Добавим путь к curl в path
setx PATH "%ProgramFiles%\curl\;%Path%"
PATH=%ProgramFiles%\curl\;%Path%

rem Добавляем утилиту curl.exe в исключения брандмауера Windows
netsh advfirewall firewall del rule name="curl"
netsh firewall add allowedprogram "%ProgramFiles%\Curl\curl.exe" curl
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="%ProgramFiles%\Curl\curl.exe"

echo .
echo Установка CURL закончена
echo .

:ENDSUB

timeout 3 >> nul

EXIT /B
