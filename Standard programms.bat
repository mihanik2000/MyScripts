@echo off

Rem ��ਯ� ��⠭���� �⠭���⭮�� ����� �ணࠬ� � ����� ९������

rem Windows XP �� �����ন������!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	Exit /b 1
 ) 

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
	GOTO END
)

rem ****************************************************************************************
rem ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
rem ****************************************************************************************

rem ��⨢��㥬 ���஥����� ������
net user ����������� "AdminPass" /active:yes

rem �������� ���짮��⥫� user � ��஫�� 321
net user user 321 /add

rem ****************************************************************************************
rem ����ந� ������� ��ࠬ���� ����室��� ��� 㤠�񭭮�� ���������஢����.
rem ****************************************************************************************

rem ����稬 ०�� �����ய�⠭�� "��᮪�� �ந�����⥫쭮���"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

rem �⪫�砥� ��騩 ०��
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

rem ��������㥬 ���������� �몫�祭�� � �������
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

rem ����砥� ADMIN ���
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_sz /d 1 /f

rem ����稬 ����⥢�� ��࠭
netsh advfirewall set allprofiles state on

rem ����訬 �⢥��� �� ping 
netsh firewall set icmpsetting 8

rem ****************************************************************************************
rem ����ந� ����������� ����������� �� RDP
rem ****************************************************************************************

rem ����稬 ����������� �ᯮ�짮����� RDP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
     
rem ����稬 ����������� �ᯮ�짮����� � 㤠�񭭮�� ����魨��
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

rem �᪫�祭�� �⥢��� ��࠭� ��� RDP
netsh advfirewall firewall del rule name="AlowRDP"
netsh firewall del portopening tcp 3389

netsh firewall set service remoteadmin enable
netsh firewall set service remotedesktop enable

netsh advfirewall firewall add rule name="AlowRDP" protocol="TCP" localport=3389 action=allow dir=IN
netsh firewall set portopening tcp 3389 AlowRDP enable 

Rem 㪠��� ०�� ����᪠ �㦡� RDP  � auto
sc config TermService start= auto

rem �����⨬ �㦡� RDP
net start TermService

rem ������塞 �⨫��� certutil.exe � �᪫�祭�� �࠭����� Windows
netsh advfirewall firewall del rule name="Certutil"
netsh firewall add allowedprogram "C:\Windows\System32\certutil.exe" Certutil
netsh advfirewall firewall add rule name="Certutil" dir=in action=allow program="C:\Windows\System32\certutil.exe"

rem ****************************************************************************************
rem ��稭��� ��⠭�������� �� �ணࠬ�� �� ��।�
rem ****************************************************************************************
mkdir C:\Windows\Temp\Mihanikus
cd C:\Windows\Temp\Mihanikus

ECHO Install curl...
mkdir  "C:\Program Files\curl\"

If exist "%programfiles(x86)%" (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.dll" "C:\Program Files\curl\libcurl-x64.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl.exe" "C:\Program Files\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl-ca-bundle.crt" "C:\Program Files\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.def" "C:\Program Files\curl\libcurl-x64.def"

 ) else (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.dll" "C:\Program Files\curl\libcurl.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl.exe" "C:\Program Files\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl-ca-bundle.crt" "C:\Program Files\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.def" "C:\Program Files\curl\libcurl.def"
)

rem ��⠭���� ᪠砭�� ���䨪�� ��� ��� ���짮��⥫��

certutil -f -addstore "My" "C:\Program Files\curl\curl-ca-bundle.crt"

rem ������塞 �⨫��� curl.exe � �᪫�祭�� �࠭����� Windows
netsh advfirewall firewall del rule name="curl"
netsh firewall add allowedprogram "C:\Program Files\curl\curl.exe" Certutil
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="C:\Program Files\curl\curl.exe"

ECHO Install 7-Zip...
 If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\7z1900-x64.msi" "http://repo.mihanik.net/7-Zip/7z1900-x64.msi"
		start /wait 7z1900-x64.msi /passive
	) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\7z1900.msi" "http://repo.mihanik.net/7-Zip/7z1900.msi"
		start /wait 7z1900.msi /passive
	)

ECHO Install dotNetFx3.5...
	Dism /online /enable-feature /featurename:NetFx3
	
ECHO Install dotNetFx4.8...
	"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\ndp48-x86-x64-allos-enu.exe" "http://repo.mihanik.net/Microsoft/Microsoft_NET/ndp48-x86-x64-allos-enu.exe"
	Start /wait ndp48-x86-x64-allos-enu.exe /q /norestart
	
ECHO Install Duplicati...
	If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\duplicati-2.0.5.103_canary_2020-02-18-x64.msi" "http://repo.mihanik.net/Duplicati/duplicati-2.0.5.103_canary_2020-02-18-x64.msi"
		Start /wait duplicati-2.0.5.103_canary_2020-02-18-x64.msi /passive
	 ) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\duplicati-2.0.5.103_canary_2020-02-18-x86.msi" "http://repo.mihanik.net/Duplicati/duplicati-2.0.5.103_canary_2020-02-18-x86.msi"
 		Start /wait duplicati-2.0.5.103_canary_2020-02-18-x86.msi  /passive
 	)

rem �᪫�祭�� �⥢��� ��࠭� ��� Duplicati
netsh advfirewall firewall del rule name="Duplicati"
netsh firewall del portopening tcp 8200
netsh advfirewall firewall add rule name="Duplicati" protocol="TCP" localport=8200 action=allow dir=IN
netsh firewall set portopening tcp 8200 Duplicati enable 

"C:\Program Files\Duplicati 2\Duplicati.WindowsService.exe" install

sc start Duplicati

del /q /s "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Duplicati 2.lnk"

ECHO Install Java SE Runtime Environment...
	If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\jre-8u201-windows-x64.exe" "http://repo.mihanik.net/Java/jre-8u241-windows-x64.exe"
		Start /wait jre-8u201-windows-x64.exe  /s
	) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\jre-8u201-windows-i586.exe" "http://repo.mihanik.net/Java/jre-8u241-windows-i586.exe"
		Start /wait jre-8u201-windows-i586.exe  /s
	)

ECHO Install LibreOffice...
	If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\LibreOffice_6.4.0_Win_x64.msi" "http://repo.mihanik.net/LibreOffice/LibreOffice_6.4.0_Win_x64.msi"
		Start /wait LibreOffice_6.4.0_Win_x64.msi  /passive
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\LibreOffice_6.4.0_Win_x64_helppack_ru.msi" "http://repo.mihanik.net/LibreOffice/LibreOffice_6.4.0_Win_x64_helppack_ru.msi"
		Start /wait LibreOffice_6.4.0_Win_x64_helppack_ru.msi  /passive

	) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\LibreOffice_6.4.0_Win_x86.msi" "http://repo.mihanik.net/LibreOffice/LibreOffice_6.4.0_Win_x86.msi"
		Start /wait LibreOffice_6.4.0_Win_x86.msi  /passive
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\LibreOffice_6.4.0_Win_x86_helppack_ru.msi" "http://repo.mihanik.net/LibreOffice/LibreOffice_6.4.0_Win_x86_helppack_ru.msi"
		Start /wait LibreOffice_6.4.0_Win_x86_helppack_ru.msi  /passive
	)

ECHO Install Unreal Commander...
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\uncomsetup3.57.exe" "http://repo.mihanik.net/UnrealCommander/uncomsetup3.57.exe"
		start uncomsetup3.57.exe /SILENT

ECHO Install Google Chrome...
	"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\ChromeSetup.exe" "http://repo.mihanik.net/ChromeSetup.exe"
	start /wait ChromeSetup.exe /silent /install

ECHO Install Skype
	"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\Skype.exe" "http://repo.mihanik.net/Skype.exe"
	start /wait Skype.exe  /silent

ECHO Install Notepad++...
	If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\npp.7.8.4.Installer.x64.exe" "http://repo.mihanik.net/Notepad/npp.7.8.4.Installer.x64.exe"
		 Start /wait npp.7.8.4.Installer.x64.exe  /S
	 ) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\npp.7.8.4.Installer.exe" "http://repo.mihanik.net/Notepad/npp.7.8.4.Installer.exe"
 		Start /wait npp.7.8.4.Installer.exe  /S
 	)

ECHO Install Thunderbird...
	If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\ThunderbirdSetup68.5.0-x64.exe" "http://repo.mihanik.net/MozillaTB/ThunderbirdSetup68.5.0-x64.exe"
		 Start /wait ThunderbirdSetup68.5.0-x64.exe -ms
	 ) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\ThunderbirdSetup68.5.0.exe" "http://repo.mihanik.net/MozillaTB/ThunderbirdSetup68.5.0.exe"
 		Start /wait ThunderbirdSetup68.5.0.exe -ms
 	)

ECHO Install FirefoxSetup...
	If exist "%programfiles(x86)%" (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\FirefoxSetup.x64.exe" "http://repo.mihanik.net/Firefox/FirefoxSetup.x64.exe"
		 Start /wait FirefoxSetup.x64.exe /SILENT
	 ) else (
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\FirefoxSetup.exe" "http://repo.mihanik.net/Firefox/FirefoxSetup.exe"
 		Start /wait FirefoxSetup.exe /SILENT
 	)

ECHO Install LiteManager Pro...
	"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\LiteManagerPro-Server.msi" "http://repo.mihanik.net/LiteManager/LiteManagerPro-Server.msi"
 	Start /wait LiteManagerPro-Server.msi /passive	
	sc start ROMService

ECHO Install Adobe Acrobat Reader...
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\AcroRdrDC1900820071_ru_RU_win.exe" "http://repo.mihanik.net/Adobe_Acrobat_Reader/AcroRdrDC1900820071_ru_RU.exe"
		Start /wait AcroRdrDC1900820071_ru_RU_win.exe /sPB

REM ECHO ...
REM ECHO Install Adobe flash player
REM ECHO ...

rem Windows 7?
rem ver | find "6.1."

rem If %errorlevel%==0  (
rem 		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\WinXP-7-Chrome-install_flash_player_ppapi.exe" "http://repo.mihanik.net/Adobe_Flash_Player/WinXP-7-Chrome-install_flash_player_ppapi.exe"
rem 		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\WinXP-7-Explorer-install_flash_player_ax.exe" "http://repo.mihanik.net/Adobe_Flash_Player/WinXP-7-Explorer-install_flash_player_ax.exe"
rem 		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\WinXP-7-Firefox-install_flash_player.exe" "http://repo.mihanik.net/Adobe_Flash_Player/WinXP-7-Firefox-install_flash_player.exe"
rem 		Start /wait WinXP-7-Chrome-install_flash_player_ppapi.exe /VERYSILENT
rem 		Start /wait WinXP-7-Explorer-install_flash_player_ax.exe /VERYSILENT
rem 		Start /wait WinXP-7-Firefox-install_flash_player.exe /VERYSILENT
rem  ) else (
rem 		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\Win8-10-Chrome-install_flash_player_ppapi.exe" "http://repo.mihanik.net/Adobe_Flash_Player/Win8-10-Chrome-install_flash_player_ppapi.exe"
rem 		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\Win8-10-Firefox-install_flash_player.exe" "http://repo.mihanik.net/Adobe_Flash_Player/Win8-10-Firefox-install_flash_player.exe"
rem 		Start /wait Win8-10-Chrome-install_flash_player_ppapi.exe /VERYSILENT
rem 		Start /wait Win8-10-Firefox-install_flash_player.exe /VERYSILENT
rem )

ECHO Install K-Lite_Codec_Pack...
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\K-Lite_Codec_Pack_1425_Mega.exe" "http://repo.mihanik.net/K-Lite/K-Lite_Codec_Pack_1425_Mega.exe"
		Start /wait K-Lite_Codec_Pack_1425_Mega.exe /silent

ECHO Install AIMP...
		"C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\aimp_4.60.2177.exe" "http://repo.mihanik.net/Aimp/aimp_4.60.2177.exe"
		Start /wait aimp_4.60.2177.exe /AUTO /SILENT

REM ECHO Install Bullzip PDF Printer
		REM "C:\Program Files\curl\curl.exe" -o "C:\Windows\Temp\Mihanikus\Setup_BullzipPDFPrinter_11_13_0_2823_FREE.exe" "http://repo.mihanik.net/bullzip/Setup_BullzipPDFPrinter_11_13_0_2823_FREE.exe"
		REM Start /wait Setup_BullzipPDFPrinter_11_13_0_2823_FREE.exe
	
:CONTINUE
	ECHO .
	ECHO ���!
	ECHO .
	
:END

PAUSE

EXIT /B
