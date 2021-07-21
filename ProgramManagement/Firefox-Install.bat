@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: You must first run Curl-Install.bat and Wget-Install.bat
REM
REM Install Firefox
REM
REM ****************************************

REM Проверяем наличие у пользователя админских прав...
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

REM Задаём значения переменных
set MyFolder=%SystemRoot%\TMP\Mihanikus

set URLFirefoxSetup="https://cache-mskm908.cdn.yandex.net/download.cdn.yandex.net/mozilla/FirefoxSetup.exe"
set URLFirefoxSetup-x64="https://cache-mskm908.cdn.yandex.net/download.cdn.yandex.net/mozilla/FirefoxSetup.x64.exe"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Firefox...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\FirefoxSetup.x64.exe" %URLFirefoxSetup-x64%
         Start /wait FirefoxSetup.x64.exe /SILENT
     ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\FirefoxSetup.exe" %URLFirefoxSetup%
        Start /wait FirefoxSetup.exe /SILENT
    )

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
