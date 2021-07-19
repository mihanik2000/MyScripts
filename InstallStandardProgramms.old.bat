
set MyUserAgent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36"

set URLndp48="http://repo.mihanik.net/Microsoft/Microsoft_NET/ndp48-x86-x64-allos-enu.exe"
rem set URLndp48="https://go.microsoft.com/fwlink/?linkid=2088631"

set URLduplicati="https://updates.duplicati.com/beta/duplicati-2.0.5.1_beta_2020-01-18-x86.msi"
set URLduplicati-x64="https://updates.duplicati.com/beta/duplicati-2.0.5.1_beta_2020-01-18-x64.msi"

set URLjre="http://repo.mihanik.net/Java/jre-8u241-windows-i586.exe"
set URLjre-x64="http://repo.mihanik.net/Java/jre-8u241-windows-x64.exe"

set URLLibreOffice="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86/LibreOffice_7.0.1_Win_x86.msi"
set URLLibreOffice-helppack="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86/LibreOffice_7.0.1_Win_x86_helppack_ru.msi"

set URLLibreOffice-x64="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86_64/LibreOffice_7.0.1_Win_x64.msi"
set URLLibreOffice-helppack-x64="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86_64/LibreOffice_7.0.1_Win_x64_helppack_ru.msi"

set URLuncomsetup="https://unrealcommander.org/download/evolution/uncomsetup3.57(build1486).exe"

set URLGoogleChrome="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5E813859-E748-6A1E-715A-14E59A2D35C5%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dstable-arch_x86-statsdef_0%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise.msi"
set URLGoogleChrome-x64="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5E813859-E748-6A1E-715A-14E59A2D35C5%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dx64-stable-statsdef_0%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise64.msi"

set URLSkype="https://download.skype.com/s4l/download/win/Skype-8.65.0.76.exe"

set URLNotepad="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9/npp.7.9.Installer.exe"
set URLNotepad-x64="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9/npp.7.9.Installer.x64.exe"

set URLthunderbird="https://download.mozilla.org/?product=thunderbird-78.3.2-SSL&os=win&lang=ru"
set URLthunderbird-x64="https://download.mozilla.org/?product=thunderbird-78.3.2-SSL&os=win64&lang=ru"

set URLFirefoxSetup="https://yandex.ru/firefox/download?from=lp_s"
set URLFirefoxSetup-x64="https://yandex.ru/firefox/download?from=lp_s"

set URLWget="https://eternallybored.org/misc/wget/1.20.3/32/wget.exe"
set URLWget-x64="https://eternallybored.org/misc/wget/1.20.3/64/wget.exe"

set URLaimp="https://www.aimp.ru/?do=download.file&id=4"

set URLKLite="https://files3.codecguide.com/K-Lite_Codec_Pack_1575_Mega.exe"


ECHO .
ECHO Install Java SE Runtime Environment...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\jre-x64.exe" %URLjre-x64%
		Start /wait jre-x64.exe  /s
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\jre.exe" %URLjre%
		Start /wait jre.exe  /s
	)

ECHO .
ECHO Install Unreal Commander...
		wget.exe --no-check-certificate -O "%MyFolder%\uncomsetup.exe" %URLuncomsetup%
		start uncomsetup.exe /SILENT

REM ECHO .
REM ECHO Install Google Chrome...
	REM wget.exe --no-check-certificate -O "%MyFolder%\ChromeSetup.exe" %URLGoogleChrome-x64%
	REM start /wait ChromeSetup.exe /silent /install

ECHO .
ECHO Install Google Chrome...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\googlechromestandaloneenterprise64.msi" %URLGoogleChrome-x64%
		Start /wait googlechromestandaloneenterprise64.msi /passive /norestart
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\googlechromestandaloneenterprise.msi" %URLGoogleChrome%
 		Start /wait googlechromestandaloneenterprise.msi /passive /norestart
 	)

ECHO .
ECHO Install Skype
	wget.exe --no-check-certificate -O "%MyFolder%\Skype.exe" %URLSkype%
	start /wait Skype.exe /silent

ECHO .
ECHO Install Notepad++...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\npp-x64.exe" %URLNotepad-x64%
		Start /wait npp-x64.exe /S
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\npp.exe" %URLNotepad%
 		Start /wait npp.exe /S
 	)

ECHO .
ECHO Install Thunderbird...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\ThunderbirdSetup-x64.exe" %URLthunderbird-x64%
		 Start /wait ThunderbirdSetup-x64.exe -ms
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\ThunderbirdSetup.exe" %URLthunderbird%
 		Start /wait ThunderbirdSetup.exe -ms
 	)

ECHO .
ECHO Install FirefoxSetup...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\FirefoxSetup.x64.exe" %URLFirefoxSetup-x64%
		 Start /wait FirefoxSetup.x64.exe /SILENT
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\FirefoxSetup.exe" %URLFirefoxSetup%
 		Start /wait FirefoxSetup.exe /SILENT
 	)

ECHO .
ECHO Install LiteManager Pro...
	wget.exe --no-check-certificate -O "%MyFolder%\LiteManagerPro-Server.msi" "http://repo.mihanik.net/LiteManager/LiteManagerPro-Server.msi"
 	Start /wait LiteManagerPro-Server.msi /passive /norestart	
	sc start ROMService

ECHO .
ECHO Install Adobe Acrobat Reader...
		wget.exe --no-check-certificate -O "%MyFolder%\AcroRdrDC1900820071_ru_RU_win.exe" "http://repo.mihanik.net/Adobe_Acrobat_Reader/AcroRdrDC1900820071_ru_RU.exe"
		Start /wait AcroRdrDC1900820071_ru_RU_win.exe /sPB


ECHO .
ECHO Install K-Lite_Codec_Pack...
		wget.exe --no-check-certificate -O "%MyFolder%\K-Lite_Codec_Pack_Mega.exe" %URLKLite%
		Start /wait K-Lite_Codec_Pack_Mega.exe /silent

ECHO .
ECHO Install AIMP...
		wget.exe --no-check-certificate -O "%MyFolder%\aimp.exe" %URLaimp%
		Start /wait aimp.exe /AUTO /SILENT

