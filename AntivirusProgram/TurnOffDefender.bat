@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
REM
REM ****************************************

rem ****************************************************************************************
rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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

REM �⪫�稬 ���⭨�� Windows �१ powershell
powershell -command "Set-MpPreference -DisableArchiveScanning $true"
powershell -command "Set-MpPreference -DisableAutoExclusions $true"
powershell -command "Set-MpPreference -DisableBehaviorMonitoring $true"
powershell -command "Set-MpPreference -DisableBlockAtFirstSeen $true"
powershell -command "Set-MpPreference -DisableIOAVProtection $true"
powershell -command "Set-MpPreference -DisablePrivacyMode $true"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $true"
powershell -command "Set-MpPreference -DisableScanningNetworkFiles $true"
powershell -command "Set-MpPreference -DisableScriptScanning $true"

REM �⪫�稬 ���⭨�� Windows �१ ॥���
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f

:CONTINUE
	ECHO .
	ECHO ����� �㤥� �믮����� ��१���㧪�!!!
	ECHO .

shutdown -r -f -t 5

:ENDSUB

timeout 5 > nul

EXIT /B
