@Rem Отключаем вывод самих команд на экран
@echo off

rem ****************************************************************************************
rem Проверяем наличие у пользователя админских прав...
rem ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run!!!
	ECHO .
	GOTO ENDSUB
)

REM Переходим на системный диск
%SystemDrive%

rem ****************************************************************************************
rem Удаляем Edge Chromium
rem ****************************************************************************************

ECHO .
ECHO Удаляем Edge Chromium...
ECHO .

 If exist "%programfiles(x86)%" (
		cd "%SystemDrive%\Program Files (x86)\Microsoft\Edge\Application"
	) else (
		cd "%SystemDrive%\Program Files\Microsoft\Edge\Application"
	)

dir /b | findstr [0-9] > ver.txt
SET /p myvar= < ver.txt
cd %myvar%\Installer
setup.exe -uninstall -system-level -verbose-logging -force-uninstall

timeout 10 >> nul

rem ****************************************************************************************
rem Запрещаем обновляться до Edge Chromium
rem ****************************************************************************************
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B

