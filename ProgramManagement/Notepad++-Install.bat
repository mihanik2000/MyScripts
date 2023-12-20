@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: You must first run Curl-Install.bat, 7Zip-Install.bat and Wget-Install.bat
REM
REM Install Notepad++
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

set URLNotepad="https://objects.githubusercontent.com/github-production-release-asset-2e65be/33014811/652a1e58-6578-42c7-a057-bb5d502eba9e?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20231220%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231220T121108Z&X-Amz-Expires=300&X-Amz-Signature=f22e00c6c4d11ffe0a2f5072d160c92500ce135a0b0e960c67ea880d94f0655c&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=33014811&response-content-disposition=attachment%3B%20filename%3Dnpp.8.5.8.Installer.exe&response-content-type=application%2Foctet-stream"
set URLNotepad-x64="https://objects.githubusercontent.com/github-production-release-asset-2e65be/33014811/494a2864-9861-4d9c-a3db-c2c5c78ae431?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20231220%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231220T120936Z&X-Amz-Expires=300&X-Amz-Signature=255c4d3d30e7e336c955e411a4b7d16c609dccf4bc1273d93c2da32f59f64e49&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=33014811&response-content-disposition=attachment%3B%20filename%3Dnpp.8.5.8.Installer.x64.exe&response-content-type=application%2Foctet-stream"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Notepad++...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\npp-x64.exe" %URLNotepad-x64%
        Start /wait npp-x64.exe /S
     ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\npp.exe" %URLNotepad%
        Start /wait npp.exe /S
    )

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
