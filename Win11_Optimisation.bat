
@echo off
cls

echo =========================================================================
echo           Windows 11 Optimization Script By sbeteta@beteta.org                  
echo =========================================================================

:restorepoint
set /p createRestorePoint=Creer d'abord un point de restauration ? (y/n)
if /i "%createRestorePoint%"=="y" (
    wmic /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Optimization Script", 100, 7
    echo Point de restauration cree.
) else if /i "%createRestorePoint%"=="n" (
    echo Echec pour creer le point de restauration.
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto restorepoint
)

:disableipv6
set /p disableIPV6=Desactive IPv6? (y/n)
if /i "%disableIPV6%"=="y" (
    netsh interface ipv6 set interface "Ethernet" Desactivation
    netsh interface ipv6 set interface "Wi-Fi" Desactivation
    echo IPv6 desactive.
) else if /i "%disableIPV6%"=="n" (
    echo Echec Desactivation de IPv6.
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disableipv6
)

:optimizenetwork
set /p optimizeNetwork=Optimiser les paramètres reseaux ? (y/n)
if /i "%optimizeNetwork%"=="y" (
    netsh int tcp set global autotuninglevel=normal
    netsh int tcp set global rss=enabled
    reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
    reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
    echo Paramètres reseau optimises.
) else if /i "%optimizeNetwork%"=="n" (
    echo Echec pour optimiser les paramètres reseau
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto optimizenetwork
)

:cleartempfiles
set /p clearTempFiles=Effacer les fichiers temporaires ? (y/n)
if /i "%clearTempFiles%"=="y" (
    del /s /q /f %temp%\*
    rd /s /q %temp%
    md %temp%
    echo Fichiers temporaires effaces.
) else if /i "%clearTempFiles%"=="n" (
    echo Echec sur la procedure "Fichiers temporaires effaces."
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto cleartempfiles
)

:defraghdd
set /p defragHDD=Defragmenter un disque dur? (y/n)
if /i "%defragHDD%"=="y" (
    defrag C: /U /V
    echo Disque dur defragmente.
) else if /i "%defragHDD%"=="n" (
    echo Echec sur la defragmentation du disque.
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto defraghdd
)

:disablegamemode
set /p disableGameMode=Desactiver le mode jeu ? (y/n)
if /i "%disableGameMode%"=="y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
    echo Mode jeu desactive.
) else if /i "%disableGameMode%"=="n" (
    echo Echec sur la procedure "Mode jeu desactive."
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disablegamemode
)

:disablegamebar
set /p disableGameBar=Desactiver la barre de jeu ? (y/n)
if /i "%disableGameBar%"=="y" (
    PowerShell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
    reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f
    echo Game Bar Desactivation.
) else if /i "%disableGameBar%"=="n" (
    echo Echec sur la procedure "Desactiver la barre de jeu".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disablegamebar
)

:disableindexing
set /p disableIndexing=Desactiver l'indexation sur tous les lecteurs ? (y/n)
if /i "%disableIndexing%"=="y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d 0 /f
    echo Indexing Desactivation on all drives.
) else if /i "%disableIndexing%"=="n" (
    echo Echec de la procedure "Desactiver l'indexation sur tous les lecteurs".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disableindexing
)

:disablehibernation
set /p disableHibernation=Desactiver l'hibernation ? (y/n)
if /i "%disableHibernation%"=="y" (
    powercfg -h off
 reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v ShowHibernateOption /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 00000001 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 00000000 /f
    echo Hibernation Desactivation.
) else if /i "%disableHibernation%"=="n" (
    echo Echec de la procedure "Desactiver l'hibernation".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disablehibernation
)

:disabletelemetry
set /p disableTelemetry=Desactiver la telemetrie et la collecte de donnees ? (y/n)
if /i "%disableTelemetry%"=="y" (

    schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
    schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /DISABLE
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DesactivationByGroupPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Desactivation" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "400" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f
    echo Telemetrie et collecte de donnees desactive.
) else if /i "%disableTelemetry%"=="n" (
    echo  echec de la procedure "Desactiver la telemetrie et la collecte de donnees".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disabletelemetry
)

:disabletips
set /p disableTips=Desactiver les conseils/suggestions Windows ? (y/n)
if /i "%disableTips%"=="y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
    echo Windows tips/suggestions Desactivation.
) else if /i "%disableTips%"=="n" (
    echo Echec de la procedure "Desactiver les conseils/suggestions Windows".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disabletips
)

:disablehomegroup
set /p disableHomeGroup=Desactiver le groupe residentiel ? (y/n)
if /i "%disableHomeGroup%"=="y" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableHomeGroup" /t REG_DWORD /d 0 /f
    echo HomeGroup desactive.
) else if /i "%disableHomeGroup%"=="n" (
    echo Echec de la procedure "Desactiver le groupe residentiel"
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disablehomegroup
)

:disablestickykeys
set /p disableStickyKeys=Desactiver l'invite des touches remanentes ? (y/n)
if /i "%disableStickyKeys%"=="y" (
    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
    echo Sticky keys prompt Desactivation.
) else if /i "%disableStickyKeys%"=="n" (
    echo Echec de la procedure "Desactiver l'invite des touches remanentes".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disablestickykeys
)

:disablesuperfetch
set /p disableSuperfetch=Desactiver Superfetch ? (y/n)
if /i "%disableSuperfetch%"=="y" (
    sc config SysMain start=Desactivation
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
    echo Superfetch Desactivation.
) else if /i "%disableSuperfetch%"=="n" (
    echo Echec de la procedure "Desactiver Superfetch".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto disablesuperfetch
)

:spooler
set /p disablespooler=Desactiver le spouleur d'impression (y/n)
if /i "%disablespooler%"=="y" (
    PowerShell -Command net stop spooler
    echo Spooler Desactivation.
) else if /i "%disablespooler%"=="n" (
    echo Echec de la procedure "Desactiver le spouleur".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto spooler
)

:WindowsInsiderService
set /p disableWindowsInsiderService= Desactiver le service Windows Insider (y/n)
if /i "%disableWindowsInsiderService%"=="y" (
    PowerShell -Command Set-Service wisvc -StartupType Desactivation
    echo Desactivation Windows Insider Service.
) else if /i "%disableWindowsInsiderService%"=="n" (
    echo Echec de la procedure "Desactiver le service Windows Insider"
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto WindowsInsiderService
)

:DiagnosticServiceHost
set /p DesactivationiagnosticServiceHost= Desactiver l'hôte du service de diagnostic (y/n)
if /i "%DesactivationiagnosticServiceHost%"=="y" (
    PowerShell -Command "net stop DPS"
    echo Echec de la procedure "Desactiver l'hôte du service de diagnostic"
) else if /i "%DesactivationiagnosticServiceHost%"=="n" (
    echo Echec de la procedure"Desactiver l'hôte du service de diagnostic".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto DiagnosticServiceHost
)

:BITS
set /p disableBITS= Desactiver BITS ()Background Intelligent Transfer Service)(y/n)
if /i "%disableBITS%"=="y" (
    net stop wuauserv
    net stop cryptSvc
    net stop bits
    net stop msiserver
    echo Desactivation BITS.
) else if /i "%disableBITS%"=="n" (
    echo Echec de la procedure "Desactiver BITS".
) else (
    echo Entree invalide. Entrez s'il vous plait y ou n.
    goto BITS


echo Optimisation terminee ! Merci
pause 
