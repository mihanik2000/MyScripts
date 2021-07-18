@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
REM
REM Скрипт установки стандартного пакета программ с моего репозитория
REM
REM ****************************************

REM ****************************************
REM Устанавливаем значение некоторых переменных
REM ****************************************

REM Папка, в которой расположен скрипт
set ScriptPath=%~dp0

REM ****************************************************************************************
REM Проверяем наличие у пользователя админских прав...
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

REM Включение режима электропитания "Высокая производительность"
CALL %ScriptPath%\Powercfg\EnableHighPerformance.bat

:CONTINUE
    ECHO .
    ECHO Всё!
    ECHO .

:END

timeout 5  >> nul

REM shutdown -r -f -t 00

EXIT /B
